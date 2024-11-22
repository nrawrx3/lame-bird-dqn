import 'package:grpc/service_api.dart';
import 'package:lame_hexagon/my_game.dart';
import 'package:lame_hexagon/protos/rl_server.pbgrpc.dart';

class RLServer extends RLServerServiceBase {
  final MyGame game;

  RLServer({required this.game});

  @override
  Future<CreateNewGameResponse> createNewGame(
      ServiceCall call, CreateNewGameRequest request) async {
    return CreateNewGameResponse();
  }

  @override
  Future<StepGameResponse> stepGame(
      ServiceCall call, StepGameRequest request) async {
    return StepGameResponse();
  }
}
