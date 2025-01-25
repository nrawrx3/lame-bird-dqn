import 'package:flutter/material.dart';
import 'package:lame_hexagon/game_ref_notifier.dart';
import 'package:provider/provider.dart';
import 'game_state_notifier.dart';

class DebugSidebar extends StatelessWidget {
  const DebugSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final gameStateNotifier = Provider.of<GameStateNotifier>(context);
    final gameRefNotifier = Provider.of<GameRefNotifier>(context);

    // Get the list of visible walls. Create a list of x, y, w, h values.
    final visibleWalls = gameStateNotifier.gameState.visibleWallsState.walls;
    final wallList = <Widget>[];

    for (var wall in visibleWalls) {
      wallList.add(Text(
        "${wall.x.toStringAsFixed(1)}, ${wall.y.toStringAsFixed(1)}, ${wall.width.toStringAsFixed(1)}, ${wall.height.toStringAsFixed(1)}",
        style: const TextStyle(fontSize: 12, fontFamily: "Gopher Mono"),
      ));
    }

    return Expanded(
      child: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("gRPC state:"),
              Text(
                "${gameStateNotifier.rlControlState}",
                style: const TextStyle(fontSize: 12, fontFamily: "Gopher Mono"),
              ),
              const Text("Command reward:"),
              Text(
                "${gameRefNotifier.game?.cumulativeRLReward}",
                style: const TextStyle(fontSize: 12, fontFamily: "Gopher Mono"),
              ),
              const Divider(),
              // Add a pause button to the debug sidebar.
              const StepButton(),
              const PauseButton(),
              const Divider(),
              const Text("Visible Walls:"),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: wallList,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PauseButton extends StatelessWidget {
  const PauseButton({super.key});

  @override
  Widget build(BuildContext context) {
    final gameRefNotifier = Provider.of<GameRefNotifier>(context);

    return ElevatedButton(
      onPressed: () {
        gameRefNotifier.game?.togglePause();
      },
      child: const Text("Pause"),
    );
  }
}

class StepButton extends StatelessWidget {
  const StepButton({super.key});

  @override
  Widget build(BuildContext context) {
    final gameRefNotifier = Provider.of<GameRefNotifier>(context);

    return ElevatedButton(
      onPressed: () {
        gameRefNotifier.game?.step(0.016);
      },
      child: const Text("Step"),
    );
  }
}
// 