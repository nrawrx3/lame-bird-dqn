import 'package:grpc/grpc.dart';
import 'package:lame_hexagon/config.dart';
import 'generated/rlbird.pbgrpc.dart';

class RLBirdClient {
  late RLBirdServerClient stub;

  RLBirdClient(String host, int port) {
    final channel = ClientChannel(
      host,
      port: port,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    stub = RLBirdServerClient(channel);
  }

  Future<Command> getNextCommand(GetNextCommandRequest request) async {
    if (disableRLClient) {
      return Command(
        commandType: Command_CommandType.NOOP,
      );
    }

    return await stub.getNextCommand(request);
  }

  Future<void> setCommandResult(SetCommandResultRequest request) async {
    if (disableRLClient) {
      return;
    }
    await stub.setCommandResult(request);
  }
}
