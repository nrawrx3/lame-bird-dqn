import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:lame_hexagon/config.dart';
import 'package:lame_hexagon/fixed_update.dart';
import 'package:lame_hexagon/my_game.dart';

class Ball extends RectangleComponent
    with CollisionCallbacks, HasGameReference<MyGame>, FixedUpdateMixin {
  Vector2 vPrev;
  Vector2 v;
  Vector2 a;

  ParticleSystemComponent? brokenPiecesParticles;

  Ball({
    required this.v,
    required this.a,
    required super.position,
    required double radius,
  })  : vPrev = v.clone(),
        super(
            size: Vector2.all(radius * 2),
            anchor: Anchor.center,
            paint: Paint()
              ..color = const Color.fromARGB(255, 0, 0, 0)
              ..style = PaintingStyle.fill,
            children: [CircleHitbox()]);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
  }

  void recreateBrokenPieces() {
    brokenPiecesParticles?.removeFromParent();

    brokenPiecesParticles = ParticleSystemComponent(
      particle: Particle.generate(
        count: 30,
        lifespan: 2.0,
        generator: (i) => AcceleratedParticle(
          acceleration: Vector2(0, 200),
          speed: Vector2(-v.x * 0.4 * game.rng.nextDouble(),
              -500 + game.rng.nextDouble() * 500),
          position: position.clone(),
          child: CircleParticle(
            radius: 5,
            paint: Paint()..color = const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
    );

    game.world.add(brokenPiecesParticles!);
  }

  @override
  update(double dt) {
    // debugPrint('Ball position: $position');
    super.update(dt);

    if (game.isAwaitingStepCommand) {
      return;
    }

    if (game.tapCount == 0 || game.isPaused) {
      return;
    }

    accumulateDt(dt);
  }

  @override
  void fixedUpdate(double dt) {
    if (game.tapCount == 0) {
      return;
    }

    if (game.isAwaitingStepCommand) {
      return;
    }

    position += vPrev * dt;
    // position += v * dt;
    vPrev.setFrom(v);
    v += a * dt;

    if (preventBallOutOfBounds) {
      // Prevent ball from falling beyond the screen
      if (position.y + size.y / 2 > viewHeight * 1.1) {
        position.y = viewHeight - size.y / 2;
        v.y = -300; // Apply an upward impulse
      }
    }
  }

  // Add an impulse velocity to the ball
  void addVelocity(Vector2 impulse) {
    // vPrev += impulse;
    v.y = impulse.y;
  }

  void addYPosition(double y) {
    position.y += y;
  }
}
