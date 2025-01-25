import 'package:flutter/material.dart';
import 'package:lame_hexagon/my_game.dart';

class GameRefNotifier with ChangeNotifier {
  MyGame? _game;

  MyGame? get game => _game;

  void setGame(MyGame game) {
    _game = game;
    notifyListeners();
  }
}
