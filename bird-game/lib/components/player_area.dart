import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:lame_hexagon/config.dart';
import 'package:lame_hexagon/my_game.dart';

class PlayArea extends RectangleComponent with HasGameReference<MyGame> {
  PlayArea()
      : super(
            paint: Paint()..color = const Color.fromARGB(255, 87, 193, 197),
            children: [RectangleHitbox()]);

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    size = Vector2(300, 300);
  }
}
