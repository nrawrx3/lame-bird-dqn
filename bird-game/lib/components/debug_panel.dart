import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:lame_hexagon/my_game.dart';

class DebugCountPanel extends PositionComponent with HasGameReference<MyGame> {
  late TextComponent _textComponent;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    _textComponent = TextComponent(
      text: 'Collisions: 0, Points: 0',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Color.fromARGB(255, 210, 13, 78),
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    add(_textComponent);

    position = Vector2(10, 10); // Position the panel in the top-left corner
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (game.tapCount == 0) {
      _textComponent.text = 'Tap to start';
      return;
    }

    if (game.isPaused) {
      _textComponent.text = 'Paused';
      return;
    }

    if (game.isAwaitingStepCommand) {
      _textComponent.text = 'Awaiting step command';
      return;
    }

    _textComponent.text =
        'Collisions: ${game.badCollisionCount} Points: ${game.points}';
  }
}
