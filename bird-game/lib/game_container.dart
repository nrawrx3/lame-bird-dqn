import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:lame_hexagon/config.dart' as config;
import 'package:lame_hexagon/generated/rlbird.pb.dart';
import 'package:lame_hexagon/rlbird_client.dart';
import 'package:provider/provider.dart';
import 'my_game.dart';
import 'game_state_notifier.dart';

class GameContainer extends StatelessWidget {
  const GameContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final rlClient = Provider.of<RLBirdClient>(context);
    final gameStateNotifier =
        Provider.of<GameStateNotifier>(context, listen: false);

    void notifyGameStateChange(GameState gameState) {
      gameStateNotifier.setGameState(gameState);
    }

    final myGame = MyGame(
      0xdeadc0de,
      config.rlTrainDifficulty,
      config.DifficultyParams.get(config.rlTrainDifficulty),
      rlClient,
      notifyGameStateChange: notifyGameStateChange,
    );

    return SizedBox(
      width: 534,
      height: 300,
      child: GameWidget(
        game: myGame,
      ),
    );
  }
}
