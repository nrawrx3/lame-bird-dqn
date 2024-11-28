import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:lame_hexagon/config.dart';
import 'package:lame_hexagon/my_game.dart';
import 'package:lame_hexagon/rlbird_client.dart';
import 'package:provider/provider.dart';

class AppSelector extends StatelessWidget {
  const AppSelector({super.key});

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
                      builder: (context) => const WallGeneratorScreen()));
                },
                child: const Text('Build walls')),
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
                      builder: (context) => const WallVisualizingScreen()));
                },
                child: const Text('Visualize walls')),
          ),
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
        DifficultyParams.get(_difficultyLevel), rlClient);

    return Scaffold(
      body: GameWidget(
        game: myGame,
      ),
    );
  }
}

class WallGeneratorScreen extends StatelessWidget {
  const WallGeneratorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
          game: MyGame(
              0xdeadc0de,
              _difficultyLevel,
              DifficultyParams.get(_difficultyLevel),
              Provider.of<RLBirdClient>(context),
              gameMode: GameMode.wallBuilding)),
    );
  }
}

class WallVisualizingScreen extends StatelessWidget {
  const WallVisualizingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
          game: MyGame(
              0xdeadc0de,
              _difficultyLevel,
              DifficultyParams.get(_difficultyLevel),
              Provider.of<RLBirdClient>(context),
              gameMode: GameMode.wallVisualizing)),
    );
  }
}
