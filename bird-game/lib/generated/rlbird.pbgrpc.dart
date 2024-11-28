//
//  Generated code. Do not modify.
//  source: rlbird.proto
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

import 'rlbird.pb.dart' as $0;

export 'rlbird.pb.dart';

@$pb.GrpcServiceName('rlbird.RLBirdServer')
class RLBirdServerClient extends $grpc.Client {
  static final _$getNextCommand = $grpc.ClientMethod<$0.GetNextCommandRequest, $0.Command>(
      '/rlbird.RLBirdServer/GetNextCommand',
      ($0.GetNextCommandRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Command.fromBuffer(value));
  static final _$setCommandResult = $grpc.ClientMethod<$0.SetCommandResultRequest, $0.SetCommandResultResponse>(
      '/rlbird.RLBirdServer/SetCommandResult',
      ($0.SetCommandResultRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SetCommandResultResponse.fromBuffer(value));

  RLBirdServerClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.Command> getNextCommand($0.GetNextCommandRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getNextCommand, request, options: options);
  }

  $grpc.ResponseFuture<$0.SetCommandResultResponse> setCommandResult($0.SetCommandResultRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setCommandResult, request, options: options);
  }
}

@$pb.GrpcServiceName('rlbird.RLBirdServer')
abstract class RLBirdServerServiceBase extends $grpc.Service {
  $core.String get $name => 'rlbird.RLBirdServer';

  RLBirdServerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetNextCommandRequest, $0.Command>(
        'GetNextCommand',
        getNextCommand_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetNextCommandRequest.fromBuffer(value),
        ($0.Command value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SetCommandResultRequest, $0.SetCommandResultResponse>(
        'SetCommandResult',
        setCommandResult_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SetCommandResultRequest.fromBuffer(value),
        ($0.SetCommandResultResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.Command> getNextCommand_Pre($grpc.ServiceCall call, $async.Future<$0.GetNextCommandRequest> request) async {
    return getNextCommand(call, await request);
  }

  $async.Future<$0.SetCommandResultResponse> setCommandResult_Pre($grpc.ServiceCall call, $async.Future<$0.SetCommandResultRequest> request) async {
    return setCommandResult(call, await request);
  }

  $async.Future<$0.Command> getNextCommand($grpc.ServiceCall call, $0.GetNextCommandRequest request);
  $async.Future<$0.SetCommandResultResponse> setCommandResult($grpc.ServiceCall call, $0.SetCommandResultRequest request);
}
