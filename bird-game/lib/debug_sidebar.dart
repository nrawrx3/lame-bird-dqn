import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_state_notifier.dart';

class DebugSidebar extends StatelessWidget {
  const DebugSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final gameStateNotifier = Provider.of<GameStateNotifier>(context);

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
              // const Text(
              //   "Debug Sidebar",
              //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              // ),
              const Text("gRPC state:"),
              Text(
                "${gameStateNotifier.rlControlState}",
                style: const TextStyle(fontSize: 12, fontFamily: "Gopher Mono"),
              ),
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
