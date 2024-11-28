import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:lame_hexagon/app_selector.dart';
import 'package:lame_hexagon/rlbird_client.dart';
import 'package:provider/provider.dart';

void main() async {
  Flame.device.fullScreen();
  Flame.device.setLandscape();

  // Need the reference to the inner server object so we can set a reference to MyGame in it.
  final rlClient = RLBirdClient("127.0.0.1", 50051);

  runApp(Provider<RLBirdClient>(
    create: (_) => rlClient,
    child: const AppSelector(),
  ));
}
