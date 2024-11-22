import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lame_hexagon/components/ball.dart';
import 'package:lame_hexagon/components/collision_count.dart';
import 'package:lame_hexagon/config.dart';
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
  rl_training,
}

class MyGame extends FlameGame
    with HasCollisionDetection, KeyboardEvents, TapCallbacks {
  final cameraBounds = Vector2(viewWidth, viewHeight);

  final DifficultyParams diffParams;

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

  late RectangleComponent backgroundRect;
  MyGame(int seed, this.difficultyLevel, this.diffParams,
      {this.gameMode = GameMode.playing})
      : ball = Ball(
            v: Vector2(diffParams.ballMaxVelocity, 0),
            a: Vector2(0, diffParams.g),
            position: Vector2(50, 0),
            radius: diffParams.ballRadius),
        rng = Random(seed),
        super(
            camera: CameraComponent.withFixedResolution(
                width: viewWidth, height: viewHeight));

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    // camera.viewport =
    //     FixedResolutionViewport(resolution: Vector2(viewWidth, viewHeight));

    camera.viewfinder.anchor = Anchor.center;

    final parallaxComponent = await loadParallaxComponent([
      ParallaxImageData('bg.png'),
      ParallaxImageData('bg_white.png'),
    ],
        baseVelocity: Vector2(ball.v.x, 0),
        velocityMultiplierDelta: Vector2(0.2, 0));
    parallaxComponent.add(parallaxComponent);

    camera.backdrop = parallaxComponent;

    _resetGame();

    if (gameMode == GameMode.wallBuilding) {
      final wallBuilder = WallBuilder();
      // wallBuilder.priority = -10;
      add(wallBuilder);

      ball.setColor(const Color.fromARGB(255, 233, 70, 0));
    }

    // world.add(ball);
    // world.add(ballX);
    // camera.follow(ballX);

    if (gameMode == GameMode.playing) {
      // world.add(WallRefresherComponent(maxWallsInView: maxWallsInView));
      final heightGenerator = PerlinWallHeightGenerator(
        rng,
        seed: rng.nextInt(10000),
        noiseOffset: rng.nextDouble(),
        diffParams: diffParams,
      );

      final wallQueue = WallQueue(
          heightGenerator: heightGenerator, initialEndX: 1000, rng: rng);

      world.add(wallQueue);
    }

    // debugMode = true;

    camera.viewport.add(CollisionCountPanel());

    FlameAudio.audioCache.loadAll(["good_collision.wav", "bad_collision.wav"]);
  }

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

  void _resetGame() {
    _resetBallPosition();

    if (resetCount > 0) {
      world.remove(backgroundRect);
    }

    backgroundRect = RectangleComponent(
        size: Vector2(viewWidth * 2, viewHeight * 2),
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

    resetLastCollisionToGood?.update(dt);

    ballX.x = ball.position.x + viewWidth / 2 * 0.7;
    if (gameMode == GameMode.wallBuilding) {
      ballX.y = ball.position
          .y; // Follow the ball vertically as well in wall building mode.
    }

    if (tapCount == 0 || isPaused) {
      return;
    }

    accumulatedTime += dt;

    // Rotate the camera continuously.
    // camera.viewfinder.angle = 20 * pi / 180 * sin(DateTime.now().second / 10);

    // The more the collision, the more probability of rotating the camera to a random angle.
    if (!diffParams.disableCameraTilt &&
        difficultyLevel >= 2 &&
        shouldRotateCamera &&
        rng.nextDouble() < badCollisionCount.toDouble() / 100) {
      currentCameraAngle += -0.05 + rng.nextDouble() * 0.1;

      if (currentCameraAngle > maxCameraTilt) {
        currentCameraAngle = maxCameraTilt;
      }
      if (currentCameraAngle < -maxCameraTilt) {
        currentCameraAngle = -maxCameraTilt;
      }
      camera.viewfinder.angle = currentCameraAngle;

      // if (camera.viewfinder.angle == 0) {
      //   camera.viewfinder.zoom = 1;
      // } else {
      //   camera.viewfinder.zoom = camera.viewfinder.angle.abs() * 0.05;
      // }
    }

    // The more the collision, the more the ball velocity upto a max.
    ball.v.x = min(
        diffParams.ballStartingVelocity + badCollisionCount * (viewWidth / 10),
        diffParams.ballMaxVelocity);

    updateBackgroundRectPosition();
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
      !disableBallPassThrough && (resetLastCollisionToGood?.finished ?? false);
}

enum Direction { left, right, up, down }
