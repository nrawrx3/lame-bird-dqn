//
//  Generated code. Do not modify.
//  source: protos/rl_server.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'rl_server.pb.dart' as $0;

export 'rl_server.pb.dart';

@$pb.GrpcServiceName('RLServer')
class RLServerClient extends $grpc.Client {
  static final _$createNewGame =
      $grpc.ClientMethod<$0.CreateNewGameRequest, $0.CreateNewGameResponse>(
          '/RLServer/CreateNewGame',
          ($0.CreateNewGameRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CreateNewGameResponse.fromBuffer(value));
  static final _$stepGame =
      $grpc.ClientMethod<$0.StepGameRequest, $0.StepGameResponse>(
          '/RLServer/StepGame',
          ($0.StepGameRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.StepGameResponse.fromBuffer(value));

  RLServerClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateNewGameResponse> createNewGame(
      $0.CreateNewGameRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createNewGame, request, options: options);
  }

  $grpc.ResponseFuture<$0.StepGameResponse> stepGame($0.StepGameRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$stepGame, request, options: options);
  }
}

@$pb.GrpcServiceName('RLServer')
abstract class RLServerServiceBase extends $grpc.Service {
  $core.String get $name => 'RLServer';

  RLServerServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.CreateNewGameRequest, $0.CreateNewGameResponse>(
            'CreateNewGame',
            createNewGame_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.CreateNewGameRequest.fromBuffer(value),
            ($0.CreateNewGameResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.StepGameRequest, $0.StepGameResponse>(
        'StepGame',
        stepGame_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.StepGameRequest.fromBuffer(value),
        ($0.StepGameResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateNewGameResponse> createNewGame_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateNewGameRequest> request) async {
    return createNewGame(call, await request);
  }

  $async.Future<$0.StepGameResponse> stepGame_Pre(
      $grpc.ServiceCall call, $async.Future<$0.StepGameRequest> request) async {
    return stepGame(call, await request);
  }

  $async.Future<$0.CreateNewGameResponse> createNewGame(
      $grpc.ServiceCall call, $0.CreateNewGameRequest request);
  $async.Future<$0.StepGameResponse> stepGame(
      $grpc.ServiceCall call, $0.StepGameRequest request);
}
