import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:lame_hexagon/components/wall.dart';
import 'package:lame_hexagon/config.dart';
import 'package:lame_hexagon/my_game.dart';

const wallGeneratorTick = 0.064;

class WallBuilder extends PositionComponent with HasGameReference<MyGame> {
  var sampleIntervalInSeconds = 4 * 16 / 1000; // 4 60FPS frames = 64 ms
  var accumulatedSeconds = 0.0;

  var sampledBallPositions = <Vector2>[];
  var initialBallPosition = Vector2.zero();

  var generatedWalls =
      <WallComponent>[]; // List of generated walls that trail the ball.

  var addNewWallTimer =
      Timer(wallGeneratorTick, autoStart: false, repeat: true);

  WallBuilder() : super() {
    anchor = Anchor.center;
    position = Vector2.zero();

    addNewWallTimer.onTick = () {
      addTrailingWallComponents();
    };

    addNewWallTimer.start();

    debugPrint("WallBuilder created");
  }

  @override
  void update(double dt) {
    super.update(dt);
    addNewWallTimer.update(dt);

    accumulatedSeconds += dt;

    if (accumulatedSeconds >= sampleIntervalInSeconds) {
      accumulatedSeconds = 0.0;

      var ballPosition = Vector2(game.ball.position.x, game.ball.position.y);
      sampledBallPositions.add(ballPosition);
    }
  }

  void addTrailingWallComponents() {
    // Check the number of positions sampled and the number of walls already generated. We add at most 20 walls at a time.
    final trailingWallCount =
        sampledBallPositions.length - generatedWalls.length;

    const wallsToGeneratePerTick = 10;

    // How much the generated wall's will be away from the sampled position of the ball.
    const minWallStartOffset = 10.0;
    const maxWallStartOffset = 100.0;
    const minWallHeight = 100.0;
    const maxWallHeight = 200.0;
    const wallWidth = 20.0; // Keeping a constant width for the walls.

    if (trailingWallCount < wallsToGeneratePerTick) {
      return;
    }

    // debugPrint('Adding $trailingWallCount walls');

    var wallCountBeforeAddingNew = generatedWalls.length;

    for (var i = 0; i < trailingWallCount; i++) {
      final sampleIndex = wallCountBeforeAddingNew + i;

      if (sampleIndex >= sampledBallPositions.length) {
        break;
      }

      final ballPos = sampledBallPositions[sampleIndex];

      final yMax = ballPos.y -
          (game.rng.nextDouble() * (maxWallStartOffset - minWallStartOffset) +
              minWallStartOffset);

      final wallHeight =
          game.rng.nextDouble() * (maxWallHeight - minWallHeight) +
              minWallHeight;

      final yMin = yMax - wallHeight;
      final xMin = ballPos.x - wallWidth / 2;

      // Avoid creating if this overlaps with the last generated wall.
      for (var prev = 0; prev < generatedWalls.length; prev++) {
        final prevWall = generatedWalls[prev];
        if (prevWall.x <= xMin && xMin <= prevWall.xMax) {
          // debugPrint('Overlapping wall detected while generating walls, ignoring');
          continue;
        }
      }

      final wall = WallComponent()
        ..position = Vector2(xMin, yMin)
        ..size = Vector2(wallWidth, wallHeight)
        ..setColor(const Color.fromARGB(170, 212, 112, 255));

      game.world.add(wall);
      generatedWalls.add(wall);
    }

    var wallCountAfterAddingNew = generatedWalls.length;

    if (wallCountAfterAddingNew - wallCountBeforeAddingNew > 0) {
      debugPrint(
          'Added ${wallCountAfterAddingNew - wallCountBeforeAddingNew} walls');
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.save();

    super.render(canvas);

    if (sampledBallPositions.length < 2) return;

    final paint = Paint()
      ..color = const Color.fromARGB(255, 200, 50, 100)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    final path = Path();

    const compressFactor = 20.0;
    final viewportHeight = game.canvasSize.y;

    // if (game.rng.nextDouble() < 0.01) {
    //   debugPrint('viewportHeight: $viewportHeight');
    // }

    path.moveTo((sampledBallPositions[0].x) / compressFactor,
        sampledBallPositions[0].y);

    for (var i = 1; i < sampledBallPositions.length; i++) {
      final scaledY = viewportHeight / viewHeight * sampledBallPositions[i].y;
      path.lineTo((sampledBallPositions[i].x) / compressFactor, scaledY);
    }

    canvas.drawPath(path, paint);

    canvas.restore();
  }
}
