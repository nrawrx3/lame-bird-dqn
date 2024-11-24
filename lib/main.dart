import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:lame_hexagon/app_selector.dart';
import 'package:lame_hexagon/rl_server.dart';
import 'package:provider/provider.dart';

void main() async {
  Flame.device.fullScreen();
  Flame.device.setLandscape();

  // Need the reference to the inner server object so we can set a reference to MyGame in it.
  final rlServer = RLServer();

  final grpcServer = Server.create(services: [rlServer]);

  runApp(Provider<RLServer>(
    create: (_) => rlServer,
    child: const AppSelector(),
  ));

  await grpcServer.serve(port: 50051);

  debugPrint('Server listening on port ${grpcServer.port}');
}
