import 'package:grpc/grpc.dart';
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
    return await stub.getNextCommand(request);
  }

  Future<void> setCommandResult(SetCommandResultRequest request) async {
    await stub.setCommandResult(request);
  }
}
