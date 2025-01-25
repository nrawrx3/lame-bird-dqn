import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:lame_hexagon/components/wall.dart';
import 'package:lame_hexagon/config.dart';
import 'package:lame_hexagon/my_game.dart';
import 'package:lame_hexagon/wall_height_generator.dart';

class WallQueue extends Component with HasGameReference<MyGame> {
  final WallHeightGenerator _heightGenerator;
  final Random _rng;

  Queue<WallComponent> visibleWalls = Queue();
  Queue<WallComponent> outOfViewWalls = Queue();

  double startX;
  double nextStartingX;

  final _initialEndX;

  WallQueue(
      {required WallHeightGenerator heightGenerator,
      required Random rng,
      this.startX = 0.0,
      initialEndX = 1000.0})
      : _heightGenerator = heightGenerator,
        _rng = rng,
        nextStartingX = initialEndX,
        _initialEndX = initialEndX;

  void reset() {
    // Remopve all walls from the component.
    for (var wall in visibleWalls) {
      remove(wall);
    }

    for (var wall in outOfViewWalls) {
      remove(wall);
    }

    visibleWalls.clear();
    outOfViewWalls.clear();
    nextStartingX = _initialEndX;

    debugPrint('WallQueue loaded, generating initial walls');

    // Generate initial walls.
    final (initialWallDimsList, nextX) =
        _heightGenerator.generateWallHeights(startX, nextStartingX);

    for (var wallDim in initialWallDimsList) {
      final wall = WallComponent()
        ..position = Vector2(wallDim[0], wallDim[1])
        ..size = Vector2(0, 0); // Initial size is 0

      visibleWalls.add(wall);

      add(wall);
    }

    debugPrint('Initial walls generated: ${visibleWalls.length} walls');

    nextStartingX = nextX;
    addLowestNonOverlappingWallsToBackOfQueue();
  }

  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    debugPrint('WallQueue loaded, generating initial walls');

    reset();
  }

  @override
  void update(double dt) {
    super.update(dt);

    addLowestNonOverlappingWallsToBackOfQueue();
  }

  void addLowestNonOverlappingWallsToBackOfQueue() {
    final ballPosition = game.ball.position;

    // The viewing extent is 10 units to the left of the ball and 80 units to the right of the ball.
    final viewBoxMinX = ballPosition.x - viewWidth / 2;
    // final viewBoxMaxX = ballPosition.x + viewWidth / 2;

    // Dequeue walls that are out of view and queue them into the outOfViewWalls queue.

    var removeCount = 0;

    for (var wall in visibleWalls) {
      if (wall.position.x + wall.size.x < viewBoxMinX) {
        outOfViewWalls.add(wall);
        removeCount++;
      } else {
        break;
      }
    }

    for (var i = 0; i < removeCount; i++) {
      visibleWalls.removeFirst();
    }

    // if (outOfViewWalls.isNotEmpty) {
    //   debugPrint('Reusing ${outOfViewWalls.length} out of view walls');
    // }

    evaluateAndQueueOutOfViewWalls();
  }

  void evaluateAndQueueOutOfViewWalls() {
    if (outOfViewWalls.isEmpty) {
      return;
    }

    var curX = nextStartingX;

    var removeCount = 0;

    for (var wall in outOfViewWalls) {
      final (wallDimsList, nextX) =
          _heightGenerator.generateWallHeights(curX, null);
      final wallDims = wallDimsList[0];

      wall.position = Vector2(wallDims[0], wallDims[1]);
      wall.size = Vector2(wallDims[2], wallDims[3]);

      // Heuristic to decide whether to make this wall a point giving wall or not. If when adding we notice that this wall is taller than at least 5 of the walls before it, we make this a point giving wall with a high probability.

      var wallsShorterThanNew = 0;

      for (var i = visibleWalls.length - 1;
          i >= max(0, visibleWalls.length - 10);
          i--) {
        final prevWall = visibleWalls.elementAt(i);
        if (prevWall.height < wall.height) {
          wallsShorterThanNew++;
        }
      }

      // Probability of being a point giving wall is proportional to the number of wallsShorter than this wall.

      if (_rng.nextDouble() < wallsShorterThanNew / 20.0) {
        const points = [1, 2, 5];
        wall.points = points[_rng.nextInt(3)];
      } else {
        wall.points = 0;
        if (game.rng.nextDouble() <
            game.diffParams.badWallInvisibleProbability) {
          wall.height = 0;
        }
      }

      wall.setColorBasedOnPoints();

      visibleWalls.add(wall);
      // outOfViewWalls.removeFirst();
      removeCount++;
      curX = nextX;
    }

    for (var i = 0; i < removeCount; i++) {
      outOfViewWalls.removeFirst();
    }

    nextStartingX = curX;
  }
}
