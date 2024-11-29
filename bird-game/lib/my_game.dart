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
import 'package:lame_hexagon/wall_builder.dart';
import 'package:lame_hexagon/wall_height_generator.dart';
import 'package:lame_hexagon/wall_queue.dart';

enum LastCollisionType {
  point,
  bad,
}

enum GameMode {
  playing,
  wallBuilding,
  wallVisualizing,
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

  bool isPaused =
      false; // TODO: We should ignore this and depend on only the rlControlState.a

  WallQueue? _wallQueue;

  RLServerControlState _rlControlState =
      RLServerControlState.awaitingNextCommand;

  RLBirdClient rlClient;

  // ----> Tracked data for a single RL step

  Command? _nextCommand;
  int _remainingSkipFramesForNextStepCommand = numSkipFramesPerStepCommand;
  // The collisions the ball has had with the walls after a step command. We will send it to the RL server as part of StepGameResponse.
  final List<WallCollision> _wallCollisions = [];

  int frameNumber = 0;
  int _commandStartFrame = 0;
  int _commandEndFrame = 0;

  // <---- Tracked data for a single RL step

  late RectangleComponent backgroundRect;
  MyGame(int seed, this.difficultyLevel, this.diffParams, this.rlClient,
      {this.gameMode = GameMode.playing})
      : ball = Ball(
            v: Vector2(diffParams.ballMaxVelocity, 0),
            a: Vector2(0, diffParams.g),
            position: Vector2(50, 0),
            radius: diffParams.ballRadius),
        rng = Random(seed),
        super(
            camera: CameraComponent.withFixedResolution(
                width: config.viewWidth, height: config.viewHeight));

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    // timeScale = 0.5;

    // camera.viewport =
    //     FixedResolutionViewport(resolution: Vector2(viewWidth, viewHeight));

    camera.viewfinder.anchor = Anchor.center;

    resetGame();

    if (gameMode == GameMode.wallBuilding) {
      final wallBuilder = WallBuilder();
      // wallBuilder.priority = -10;
      add(wallBuilder);

      ball.setColor(const Color.fromARGB(255, 233, 70, 0));
    }

    if (gameMode == GameMode.playing) {
      // world.add(WallRefresherComponent(maxWallsInView: maxWallsInView));
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

    // debugMode = true;

    camera.viewport.add(DebugCountPanel());

    // FlameAudio.audioCache.loadAll(["good_collision.wav", "bad_collision.wav"]);

    _rlControlState = RLServerControlState.awaitingNextCommand;

    // Issue the first GetNextCommand rpc to the RL server.
    rlClient
        .getNextCommand(GetNextCommandRequest())
        .then((response) => startExecutingCommand(response));
  }

  void startExecutingCommand(Command command) {
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
    debugPrint('Resetting RL state after skipping frames.');

    _remainingSkipFramesForNextStepCommand = numSkipFramesPerStepCommand;
    _wallCollisions.clear();
    _rlControlState = RLServerControlState.awaitingNextCommand;
    _commandStartFrame = 0;
    _commandEndFrame = 0;
  }

  get isAwaitingStepCommand =>
      _rlControlState == RLServerControlState.awaitingNextCommand;

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
      } else if (event.logicalKey == LogicalKeyboardKey.keyP) {
        isPaused = !isPaused;
      }
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

  void resetGame() {
    _resetBallPosition();

    if (resetCount > 0) {
      world.remove(backgroundRect);
    }

    backgroundRect = RectangleComponent(
        size: Vector2(config.viewWidth * 2, config.viewHeight * 2),
        paint: Paint()..color = const Color.fromARGB(100, 253, 242, 242),
        anchor: Anchor.center);

    backgroundRect.position = ball.position.clone();
    backgroundRect.position.x += 100;

    world.add(backgroundRect);

    world.add(ball);
    world.add(ballX);
    camera.follow(ballX);

    resetCount++;
  }

  @override
  void update(double dt) {
    super.update(dt);

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

          final res = _applyCommand(_nextCommand!);

          // If this is a create new game command, we need to reset the game.
          if (res == ApplyCommandResult.resetGame) {
            _rlControlState = RLServerControlState.settingCommandResult;

            final commandResult = _makeCommandResult();

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
          debugPrint('Processed all frames before awaiting next step command.');

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
            debugPrint('Req next command');
            rlClient.getNextCommand(GetNextCommandRequest()).then((response) {
              startExecutingCommand(response);
            });
          });
        }

        resetLastCollisionToGood?.update(dt);

        ballX.x = ball.position.x + config.viewWidth / 2 * 0.7;
        if (gameMode == GameMode.wallBuilding) {
          ballX.y = ball.position
              .y; // Follow the ball vertically as well in wall building mode.
        }

        accumulatedTime += dt;

        // The more the collision, the more the ball velocity upto a max.
        ball.v.x = min(
            diffParams.ballStartingVelocity +
                badCollisionCount * (config.viewWidth / 10),
            diffParams.ballMaxVelocity);

        updateBackgroundRectPosition();
    }
  }

  ApplyCommandResult _applyCommand(Command command) {
    switch (command.commandType) {
      case Command_CommandType.CREATE_NEW_GAME:
        resetGame();
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

  CommandResult _makeCommandResult() {
    return CommandResult(
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
                  points: w.points.toDouble(),
                ))),
        wallCollisions: _wallCollisions,
      ),
      startFrame: _commandEndFrame,
      endFrame: _commandEndFrame,
    );

    // Take the first 10 visible walls from the wall queue.
  }

  void updateBackgroundRectPosition() {
    // Should be around the ball.
    backgroundRect.position.x = ball.position.x + 100;
    backgroundRect.position.y = ball.position.y;
    // backgroundRect.size = Vector2(viewWidth, viewHeight);
  }

  void setBackgroundColor(Color c) {
    backgroundRect.paint.color = c;
  }

  void addPoints(int pointsToAdd) {
    points += pointsToAdd;
  }

  get ballIsPassThrough =>
      !config.disableBallPassThrough &&
      (resetLastCollisionToGood?.finished ?? false);
}

enum Direction { left, right, up, down }
