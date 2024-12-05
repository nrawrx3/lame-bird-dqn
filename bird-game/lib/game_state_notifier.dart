import 'package:flutter/material.dart';
import 'package:lame_hexagon/generated/rlbird.pb.dart';
import 'package:lame_hexagon/my_game.dart';

class GameStateNotifier with ChangeNotifier {
  // TODO: Keep a deque of game states.
  GameState _gameState = GameState();

  RLServerControlState _rlControlState =
      RLServerControlState.awaitingNextCommand;

  GameState get gameState => _gameState;
  RLServerControlState get rlControlState => _rlControlState;

  void setGameState(GameState gameState) {
    _gameState = gameState;
    notifyListeners();
  }

  void setRLControlState(RLServerControlState controlState) {
    _rlControlState = controlState;
    notifyListeners();
  }
}
