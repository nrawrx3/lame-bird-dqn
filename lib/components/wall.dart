// Properties of a single wall. Not using a Rect object because we want to mutate the attributes of the wall when we regenerate.
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/widgets.dart';
import 'package:lame_hexagon/components/ball.dart';
import 'package:lame_hexagon/my_game.dart';

var heightChangeVelocity = 5; // pixels per second.

class WallComponent extends RectangleComponent
    with HasGameReference<MyGame>, CollisionCallbacks {
  RectangleHitbox hitbox = RectangleHitbox();

  WallComponent()
      : super(paint: Paint()..color = const Color.fromARGB(255, 20, 20, 20));

  get xMax => x + width;
  get yMax => y + height;

  var points = 0;

  var baseHeight = 0.0;
  var maxHeightOffset = 0.0;

  get isPointGivingWall => points > 0;

  void setColorBasedOnPoints() {
    switch (points) {
      case 0:
        paint.color = const Color.fromARGB(255, 20, 20, 20);
        break;
      case 1:
        paint.color = const Color.fromARGB(255, 239, 255, 118);
        break;
      case 2:
        paint.color = const Color.fromARGB(255, 255, 95, 154);
        break;
      case 5:
        paint.color = const Color.fromARGB(255, 255, 0, 0);
        break;
      default:
        paint.color = const Color.fromARGB(255, 255, 255, 255);
    }
  }

  @override
  void onLoad() {
    super.onLoad();

    add(hitbox);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (game.isPaused) {
      return;
    }

    if (maxHeightOffset == 0) {
      return;
    }

    // Oscillate the height of the wall.
    var newHeight = baseHeight +
        maxHeightOffset * sin(game.accumulatedTime * heightChangeVelocity);

    // debugPrint('newHeight: $newHeight, oldHeight: $height');

    height = newHeight;
    hitbox.height = height;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    if (game.gameMode == GameMode.wallBuilding) {
      return;
    }

    if (other is! Ball) {
      return;
    }

    // If this is a point giving wall and last collision type is also with a point giving wall, then we allow the ball to collide and collect a point.
    if (game.lastCollisionType == LastCollisionType.point) {
      if (isPointGivingWall) {
        handlePointGivingCollision();
      } else {
        handleBadCollision();
      }
    } else {
      // game.lastCollisionType == LastCollisionType.bad
      if (!game.ballIsPassThrough) {
        if (isPointGivingWall) {
          handlePointGivingCollision();
        } else {
          handleBadCollision();
        }
      }
    }
  }

  void handlePointGivingCollision() {
    FlameAudio.play("good_collision.wav");

    game.addPoints(points);
    game.shouldRotateCamera = false;
    height = 0;
    game.setBackgroundColor(const Color.fromARGB(150, 206, 253, 235));
    game.lastCollisionType = LastCollisionType.point;
  }

  void handleBadCollision() {
    debugPrint("Bad collision detected");

    FlameAudio.play("bad_collision.wav");

    game.badCollisionCount++;
    game.addPoints(-game.diffParams.badWallPenalty);
    game.shouldRotateCamera = true;
    game.ball.recreateBrokenPieces();
    game.setBackgroundColor(const Color.fromARGB(149, 255, 167, 167));

    game.lastCollisionType = LastCollisionType.bad;

    height = 0;

    if (game.resetLastCollisionToGood != null) {
      game.resetLastCollisionToGood
        ?..reset()
        ..start();
    } else {
      game.resetLastCollisionToGood = Timer(2.0, onTick: () {
        game.lastCollisionType = LastCollisionType.point;
        game.setBackgroundColor(const Color.fromARGB(255, 255, 255, 255));
        debugPrint("Resetting last collision type to good");
      }, repeat: false, autoStart: true);
    }
  }
}
