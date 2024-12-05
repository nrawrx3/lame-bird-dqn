import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:lame_hexagon/config.dart' as config;
import 'package:lame_hexagon/debug_sidebar.dart';
import 'package:lame_hexagon/game_container.dart';
import 'package:lame_hexagon/game_state_notifier.dart';
import 'package:lame_hexagon/my_game.dart';
import 'package:lame_hexagon/rlbird_client.dart';
import 'package:provider/provider.dart';

class GameModeSelector extends StatelessWidget {
  const GameModeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lame Bird',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MenuScreen(),
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const GameScreen()));
                },
                child: const Text('Start Game')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const GameScreenRL()));
                },
                child: const Text('Start Game (RL config)')),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10.0),
          //         ),
          //       ),
          //       onPressed: () {
          //         Navigator.of(context).push(MaterialPageRoute(
          //             builder: (context) => const WallGeneratorScreen()));
          //       },
          //       child: const Text('Build walls')),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10.0),
          //         ),
          //       ),
          //       onPressed: () {
          //         Navigator.of(context).push(MaterialPageRoute(
          //             builder: (context) => const WallVisualizingScreen()));
          //       },
          //       child: const Text('Visualize walls')),
          // ),
        ],
      )),
    );
  }
}

const _difficultyLevel = 2;

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rlClient = Provider.of<RLBirdClient>(context);
    final myGame = MyGame(0xdeadc0de, _difficultyLevel,
        config.DifficultyParams.get(_difficultyLevel), rlClient);

    return Scaffold(
      body: GameWidget(
        game: myGame,
      ),
    );
  }
}

// Parents a MyGame and a DebugSideBar. Provides GameStateNotifier to the subtree.
class GameScreenRL extends StatelessWidget {
  const GameScreenRL({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<GameStateNotifier>(
        create: (context) => GameStateNotifier(),
        child: const Row(
          children: [
            GameContainer(),
            DebugSidebar(),
          ],
        ),
      ),
    );
  }
}
