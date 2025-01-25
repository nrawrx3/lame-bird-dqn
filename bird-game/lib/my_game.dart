import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lame_hexagon/components/ball.dart';
import 'package:lame_hexagon/components/debug_panel.dart';
import 'package:lame_hexagon/components/wall.dart';
import 'package:lame_hexagon/config.dart' as config;
import 'package:lame_hexagon/generated/rlbird.pb.dart';
import 'package:lame_hexagon/rlbird_client.dart';
import 'package:lame_hexagon/wall_height_generator.dart';
import 'package:lame_hexagon/wall_queue.dart';

enum LastCollisionType {
  point,
  bad,
}

enum GameMode {
  playing,
  rlTraining,
}

// From the point of view of the RL the game can be in one of the following states:
enum RLServerControlState {
  awaitingNextCommand, // Waiting for the GetNextCommand rpc to complete.
  executingCommand,
  settingCommandResult, // Waiting for the SetCommandResult rpc to complete.
}

enum ApplyCommandResult {
  noop,
  resetGame,
  updateGame,
}

const numSkipFramesPerStepCommand = 10;

class MyGame extends FlameGame
    with HasCollisionDetection, KeyboardEvents, TapCallbacks, HasTimeScale {
  final cameraBounds = Vector2(config.viewWidth, config.viewHeight);

  final config.DifficultyParams diffParams;

  final Ball ball;

  final PositionComponent ballX = PositionComponent();

  var resetCount = 0;

  var badCollisionCount = 0;
  var points = 0;

  var currentCameraAngle = 0.0;

  var lastCollisionType = LastCollisionType.point;
  var currentBackgroundColor = const Color(0xFFFEFEFE);

  Timer? resetLastCollisionToGood;

  var tapCount = 0;
  var accumulatedTime = 0.0;
  var shouldRotateCamera = false;

  final Random rng;
  int difficultyLevel = 0;

  GameMode gameMode;

  bool isPaused = false;
  bool isGameOver = false;

  WallQueue? _wallQueue;

  double _lastPointAdded = 0;

  Function(GameState)? notifyGameStateChange;

  RLServerControlState _rlControlState =
      RLServerControlState.awaitingNextCommand;

  RLBirdClient rlClient;

  // ----> Tracked data for a single RL step

  Command? _nextCommand;
  int _remainingSkipFramesForNextStepCommand = numSkipFramesPerStepCommand;
  // The collisions the ball has had with the walls after a step command. We will send it to the RL server as part of StepGameResponse.
  final List<WallCollision> _wallCollisions = [];

  // The reward sequence for the current step command. This includes both the reward (positive or negative) for each collision and any other rewards to shape the behavior of the agent.
  final List<double> _rewardSequence = [];

  int frameNumber = 0;
  int _commandStartFrame = 0;
  int _commandEndFrame = 0;

  // <---- Tracked data for a single RL step

  // late RectangleComponent backgroundRect;
  MyGame(
    int seed,
    this.difficultyLevel,
    this.diffParams,
    this.rlClient, {
    this.gameMode = GameMode.playing,
    this.notifyGameStateChange,
  })  : ball = Ball(
            v: Vector2(diffParams.ballMaxVelocity, 0),
            a: Vector2(0, diffParams.g),
            position: Vector2(50, 0),
            radius: diffParams.ballRadius),
        rng = Random(seed),
        super(
            camera: CameraComponent.withFixedResolution(
                width: config.viewWidth, height: config.viewHeight)) {
    debugPrint('MyGame constructor called');
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    // debugMode = true;

    // timeScale = 0.5;

    camera.viewfinder.anchor = Anchor.center;

    resetGame(isCreateNewGameCommand: false);

    if (gameMode == GameMode.playing) {
      final heightGenerator = PerlinWallHeightGenerator(
        rng,
        seed: rng.nextInt(10000),
        noiseOffset: rng.nextDouble(),
        diffParams: diffParams,
      );

      _wallQueue = WallQueue(
          heightGenerator: heightGenerator, initialEndX: 1000.0, rng: rng);

      world.add(_wallQueue!);
    }

    camera.viewport.add(DebugCountPanel());

    _rlControlState = RLServerControlState.awaitingNextCommand;

    // Issue the first GetNextCommand rpc to the RL server.
    rlClient
        .getNextCommand(GetNextCommandRequest())
        .then((response) => startExecutingCommand(response));
  }

  void startExecutingCommand(Command command) {
    if (config.disableRLClient) {
      _rlControlState = RLServerControlState.executingCommand;
    }

    debugPrint('Received command from RL server: type: ${command.commandType}');

    // Do nothing if we're not in awaitingStepCommand state
    if (_rlControlState != RLServerControlState.awaitingNextCommand) {
      debugPrint(
          'processStepCommand called when not in awaitingStepCommand state, fix the client please.');

      return;
    }
    _remainingSkipFramesForNextStepCommand = numSkipFramesPerStepCommand;
    _rlControlState = RLServerControlState.executingCommand;
    _nextCommand = command;
  }

  void recordWallCollisionEvent(WallComponent wall) {
    _wallCollisions.add(WallCollision(
      wall: Wall(
        x: wall.position.x,
        y: wall.position.y,
        width: wall.width,
        height: wall.height,
        points: wall.points.toDouble(),
      ),
      ballState: BallState(
        x: ball.position.x,
        y: ball.position.y,
        vx: ball.v.x,
        vy: ball.v.y,
        ax: ball.a.x,
        ay: ball.a.y,
      ),
    ));
  }

  void _resetRLStateAfterSkipFrames() {
    // debugPrint('Resetting RL state after skipping frames.');

    _remainingSkipFramesForNextStepCommand = numSkipFramesPerStepCommand;
    _wallCollisions.clear();
    _rewardSequence.clear();
    _rlControlState = RLServerControlState.awaitingNextCommand;
    _commandStartFrame = 0;
    _commandEndFrame = 0;
  }

  get isAwaitingStepCommand =>
      _rlControlState == RLServerControlState.awaitingNextCommand;

  get isExecutingCommand =>
      _rlControlState == RLServerControlState.executingCommand;

  // For debugging.
  void panCamera(Direction direction) {
    // Assuming a panning step size of 10 units
    double panStep = 10.0;

    if (direction == Direction.left) {
      camera.moveBy(Vector2(-panStep, 0));
    } else if (direction == Direction.right) {
      camera.moveBy(Vector2(panStep, 0));
    } else if (direction == Direction.up) {
      camera.moveBy(Vector2(0, -panStep));
    } else if (direction == Direction.down) {
      camera.moveBy(Vector2(0, panStep));
    }

    // debugPrint('Camera position: ${camera.viewfinder.position}');
  }

  @override
  KeyEventResult onKeyEvent(
      KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (config.disableRLClient) {
      // debugPrint('Key pressed: ${event.logicalKey}');
      if (event is KeyDownEvent || event is KeyRepeatEvent) {
        if (event.logicalKey == LogicalKeyboardKey.keyA) {
          panCamera(Direction.left);
        } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
          panCamera(Direction.right);
        } else if (event.logicalKey == LogicalKeyboardKey.keyW) {
          panCamera(Direction.up);
        } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
          panCamera(Direction.down);
        } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
          camera.viewfinder.zoom += 0.1;
        } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
          camera.viewfinder.zoom -= 0.1;
        } else if (event.logicalKey == LogicalKeyboardKey.space) {
          handleInGameTap();
        }
      }
    }

    if (event.logicalKey == LogicalKeyboardKey.keyP) {
      isPaused = !isPaused;
    }

    return KeyEventResult.handled;
  }

  @override
  void onTapDown(TapDownEvent event) {
    handleInGameTap();
  }

  void handleInGameTap() {
    tapCount++;
    ball.addVelocity(Vector2(0, -diffParams.ballNudgeVelocity));
  }

  void _resetBallPosition() {
    if (resetCount > 0) {
      world.remove(ball);
      world.remove(ballX);
    }

    ball.position = size / 2;
    ballX.position = ball.position.clone();
  }

  void resetGame({required bool isCreateNewGameCommand}) {
    _resetBallPosition();

    if (resetCount > 0) {
      // world.remove(backgroundRect);
    }

    // backgroundRect = RectangleComponent(
    //     size: Vector2(config.viewWidth * 2, config.viewHeight * 2),
    //     paint: Paint()..color = const Color.fromARGB(100, 253, 242, 242),
    //     anchor: Anchor.center);
    // backgroundRect.position = ball.position.clone();
    // backgroundRect.position.x += 100;
    // world.add(backgroundRect);

    if (isCreateNewGameCommand) {
      isGameOver = false;
    }

    if (!isGameOver) {
      world.add(ball);
      world.add(ballX);
      camera.follow(ballX);

      _wallQueue?.reset();

      points = 0;

      resetCount++;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isPaused) {
      return;
    }

    step(dt);
  }

  void step(double dt) {
    if (isGameOver) {
      _showGameOverScreen();
    }

    switch (_rlControlState) {
      case RLServerControlState.awaitingNextCommand:
        break;

      case RLServerControlState.settingCommandResult:
        break;

      case RLServerControlState.executingCommand:
        frameNumber++;

        if (_remainingSkipFramesForNextStepCommand ==
            numSkipFramesPerStepCommand) {
          // The current skip frames count is max, means that we have not
          // yet processed the command. Apply it now.

          _commandStartFrame = frameNumber;

          final res = _applyNextCommand();

          // If this is a create new game command, we need to reset the game.
          if (res == ApplyCommandResult.resetGame) {
            _rlControlState = RLServerControlState.settingCommandResult;

            final commandResult =
                _makeCommandResult(isCreateNewGameCommand: true);

            rlClient
                .setCommandResult(
                    SetCommandResultRequest(commandResult: commandResult))
                .then((response) {
              _resetRLStateAfterSkipFrames();

              // Ask the server for the next command.
              debugPrint('Req next command');
              rlClient.getNextCommand(GetNextCommandRequest()).then((response) {
                startExecutingCommand(response);
              });
            });

            break; // We have reset the game, nothing else to update.
          }
        }

        _remainingSkipFramesForNextStepCommand =
            max(0, _remainingSkipFramesForNextStepCommand - 1);

        if (_remainingSkipFramesForNextStepCommand == 0) {
          // debugPrint('Processed all frames before awaiting next step command.');

          _commandEndFrame = frameNumber;

          // Send the command result to the RL server.
          final commandResult = _makeCommandResult();

          // Send the command result to the RL server.

          _rlControlState = RLServerControlState.settingCommandResult;

          rlClient
              .setCommandResult(SetCommandResultRequest(
            commandResult: commandResult,
          ))
              .then((response) {
            _resetRLStateAfterSkipFrames();

            // Ask the server for the next command.
            // debugPrint('Req next command');
            rlClient.getNextCommand(GetNextCommandRequest()).then((response) {
              startExecutingCommand(response);
            });
          });
        }

        resetLastCollisionToGood?.update(dt);

        ballX.x = ball.position.x + config.viewWidth / 2 * 0.7;

        // Add penalty if the ball goes out of bounds from the top. But this penalty is only exposed to the RL trainer, not the player. So add it to the reward sequence, not to the game points.
        if (ball.position.y <= 0) {
          _rewardSequence.add(-diffParams.outOfTopBoundsPenalty.toDouble());
          ball.position.y = 0;
        }

        if (_lastPointAdded >= 0 && config.goodCollisionReward > 0.0) {
          // Add a small reward if the ball did not collide with any wall in the last frame or collided with a good wall.
          _rewardSequence.add(config.goodCollisionReward);
        }

        accumulatedTime += dt;
        _lastPointAdded = 0;

        // The more the collision, the more the ball velocity upto a max.
        // ball.v.x = min(
        //     diffParams.ballStartingVelocity +
        //         badCollisionCount * (config.viewWidth / 10),
        //     diffParams.ballMaxVelocity);

        updateBackgroundRectPosition();

        if (ball.position.x >= diffParams.maxTravelDistance) {
          isGameOver = true;
        }
    }
  }

  ApplyCommandResult _applyNextCommand() {
    if (config.disableRLClient) {
      return ApplyCommandResult.noop;
    }

    final command = _nextCommand!;

    switch (command.commandType) {
      case Command_CommandType.CREATE_NEW_GAME:
        resetGame(isCreateNewGameCommand: true);
        return ApplyCommandResult.resetGame;

      case Command_CommandType.ACTION_JUMP:
        tapCount++;
        ball.addVelocity(Vector2(0, -diffParams.ballNudgeVelocity));
        return ApplyCommandResult.updateGame;

      case Command_CommandType.NOOP:
        tapCount++;
        return ApplyCommandResult.updateGame;
    }
    return ApplyCommandResult.noop;
  }

  CommandResult _makeCommandResult({bool isCreateNewGameCommand = false}) {
    final res = CommandResult(
      gameState: GameState(
        ballState: BallState(
          x: ball.position.x,
          y: ball.position.y,
          vx: ball.v.x,
          vy: ball.v.y,
          ax: ball.a.x,
          ay: ball.a.y,
        ),
        visibleWallsState: VisibleWallsState(
            walls: _wallQueue!.visibleWalls.map((w) => Wall(
                  x: w.position.x,
                  y: w.position.y,
                  width: w.width,
                  height: w.height,
                  points: w.rlReward,
                ))),
        wallCollisions: _wallCollisions,
      ),
      startFrame: _commandStartFrame,
      endFrame: _commandEndFrame,
      reward: _rewardSequence.fold(0, (a, b) => a! + b),
    );

    if (isCreateNewGameCommand) {
      debugPrint("Adding world bounds to the command result.");
      // Send the world_bounds field.
      res.worldBounds = GameWorldBounds(
        viewWidth: config.viewWidth,
        viewHeight: config.viewHeight,
        minWallGap: config.minWallGap,
        maxDistanceToTravel: diffParams.maxTravelDistance,
      );
    }

    if (isGameOver) {
      res.gameOver = true;
    }

    notifyGameStateChange?.call(res.gameState);

    return res;
  }

  void updateBackgroundRectPosition() {
    // Should be around the ball.
    // backgroundRect.position.x = ball.position.x + 100;
    // backgroundRect.position.y = ball.position.y;
    // backgroundRect.size = Vector2(viewWidth, viewHeight);
  }

  void setBackgroundColor(Color c) {
    // backgroundRect.paint.color = c;
  }

  void addCollisionPoints(int pointsToAdd) {
    points += pointsToAdd;
    _lastPointAdded = pointsToAdd.toDouble();
  }

  void addCollisionReward(double reward) {
    _rewardSequence.add(reward);
  }

  get cumulativeRLReward => _rewardSequence.fold(0.0, (a, b) => a + b);

  void togglePause() {
    isPaused = !isPaused;
  }

  void _showGameOverScreen() {}

  get ballIsPassThrough =>
      !config.disableBallPassThrough &&
      (resetLastCollisionToGood?.finished ?? false);
}

enum Direction { left, right, up, down }
