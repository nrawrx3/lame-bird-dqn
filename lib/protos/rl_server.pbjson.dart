//
//  Generated code. Do not modify.
//  source: protos/rl_server.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use createNewGameRequestDescriptor instead')
const CreateNewGameRequest$json = {
  '1': 'CreateNewGameRequest',
  '2': [
    {'1': 'seed', '3': 1, '4': 1, '5': 3, '10': 'seed'},
    {'1': 'max_walls', '3': 2, '4': 1, '5': 3, '10': 'maxWalls'},
  ],
};

/// Descriptor for `CreateNewGameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createNewGameRequestDescriptor = $convert.base64Decode(
    'ChRDcmVhdGVOZXdHYW1lUmVxdWVzdBISCgRzZWVkGAEgASgDUgRzZWVkEhsKCW1heF93YWxscx'
    'gCIAEoA1IIbWF4V2FsbHM=');

@$core.Deprecated('Use createNewGameResponseDescriptor instead')
const CreateNewGameResponse$json = {
  '1': 'CreateNewGameResponse',
  '2': [
    {'1': 'game_world_bounds', '3': 1, '4': 1, '5': 11, '6': '.GameWorldBounds', '10': 'gameWorldBounds'},
    {'1': 'difficulty_params', '3': 2, '4': 1, '5': 11, '6': '.DifficultyParams', '10': 'difficultyParams'},
    {'1': 'game_state', '3': 3, '4': 1, '5': 11, '6': '.GameState', '10': 'gameState'},
  ],
};

/// Descriptor for `CreateNewGameResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createNewGameResponseDescriptor = $convert.base64Decode(
    'ChVDcmVhdGVOZXdHYW1lUmVzcG9uc2USPAoRZ2FtZV93b3JsZF9ib3VuZHMYASABKAsyEC5HYW'
    '1lV29ybGRCb3VuZHNSD2dhbWVXb3JsZEJvdW5kcxI+ChFkaWZmaWN1bHR5X3BhcmFtcxgCIAEo'
    'CzIRLkRpZmZpY3VsdHlQYXJhbXNSEGRpZmZpY3VsdHlQYXJhbXMSKQoKZ2FtZV9zdGF0ZRgDIA'
    'EoCzIKLkdhbWVTdGF0ZVIJZ2FtZVN0YXRl');

@$core.Deprecated('Use gameWorldBoundsDescriptor instead')
const GameWorldBounds$json = {
  '1': 'GameWorldBounds',
  '2': [
    {'1': 'view_width', '3': 1, '4': 1, '5': 1, '10': 'viewWidth'},
    {'1': 'view_height', '3': 2, '4': 1, '5': 1, '10': 'viewHeight'},
    {'1': 'min_wall_gap', '3': 3, '4': 1, '5': 1, '10': 'minWallGap'},
  ],
};

/// Descriptor for `GameWorldBounds`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gameWorldBoundsDescriptor = $convert.base64Decode(
    'Cg9HYW1lV29ybGRCb3VuZHMSHQoKdmlld193aWR0aBgBIAEoAVIJdmlld1dpZHRoEh8KC3ZpZX'
    'dfaGVpZ2h0GAIgASgBUgp2aWV3SGVpZ2h0EiAKDG1pbl93YWxsX2dhcBgDIAEoAVIKbWluV2Fs'
    'bEdhcA==');

@$core.Deprecated('Use difficultyParamsDescriptor instead')
const DifficultyParams$json = {
  '1': 'DifficultyParams',
  '2': [
    {'1': 'ball_max_velocity', '3': 1, '4': 1, '5': 1, '10': 'ballMaxVelocity'},
    {'1': 'ball_starting_velocity', '3': 2, '4': 1, '5': 1, '10': 'ballStartingVelocity'},
    {'1': 'disable_camera_tilt', '3': 3, '4': 1, '5': 8, '10': 'disableCameraTilt'},
    {'1': 'ball_nudge_velocity', '3': 4, '4': 1, '5': 1, '10': 'ballNudgeVelocity'},
    {'1': 'noise_scale', '3': 5, '4': 1, '5': 1, '10': 'noiseScale'},
    {'1': 'g', '3': 6, '4': 1, '5': 1, '10': 'g'},
    {'1': 'bad_wall_invisible_probability', '3': 7, '4': 1, '5': 1, '10': 'badWallInvisibleProbability'},
    {'1': 'max_wall_height', '3': 8, '4': 1, '5': 1, '10': 'maxWallHeight'},
    {'1': 'min_wall_height', '3': 9, '4': 1, '5': 1, '10': 'minWallHeight'},
    {'1': 'bad_wall_penalty', '3': 10, '4': 1, '5': 5, '10': 'badWallPenalty'},
    {'1': 'max_wall_width', '3': 11, '4': 1, '5': 1, '10': 'maxWallWidth'},
    {'1': 'min_wall_width', '3': 12, '4': 1, '5': 1, '10': 'minWallWidth'},
    {'1': 'ball_radius', '3': 13, '4': 1, '5': 1, '10': 'ballRadius'},
  ],
};

/// Descriptor for `DifficultyParams`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List difficultyParamsDescriptor = $convert.base64Decode(
    'ChBEaWZmaWN1bHR5UGFyYW1zEioKEWJhbGxfbWF4X3ZlbG9jaXR5GAEgASgBUg9iYWxsTWF4Vm'
    'Vsb2NpdHkSNAoWYmFsbF9zdGFydGluZ192ZWxvY2l0eRgCIAEoAVIUYmFsbFN0YXJ0aW5nVmVs'
    'b2NpdHkSLgoTZGlzYWJsZV9jYW1lcmFfdGlsdBgDIAEoCFIRZGlzYWJsZUNhbWVyYVRpbHQSLg'
    'oTYmFsbF9udWRnZV92ZWxvY2l0eRgEIAEoAVIRYmFsbE51ZGdlVmVsb2NpdHkSHwoLbm9pc2Vf'
    'c2NhbGUYBSABKAFSCm5vaXNlU2NhbGUSDAoBZxgGIAEoAVIBZxJDCh5iYWRfd2FsbF9pbnZpc2'
    'libGVfcHJvYmFiaWxpdHkYByABKAFSG2JhZFdhbGxJbnZpc2libGVQcm9iYWJpbGl0eRImCg9t'
    'YXhfd2FsbF9oZWlnaHQYCCABKAFSDW1heFdhbGxIZWlnaHQSJgoPbWluX3dhbGxfaGVpZ2h0GA'
    'kgASgBUg1taW5XYWxsSGVpZ2h0EigKEGJhZF93YWxsX3BlbmFsdHkYCiABKAVSDmJhZFdhbGxQ'
    'ZW5hbHR5EiQKDm1heF93YWxsX3dpZHRoGAsgASgBUgxtYXhXYWxsV2lkdGgSJAoObWluX3dhbG'
    'xfd2lkdGgYDCABKAFSDG1pbldhbGxXaWR0aBIfCgtiYWxsX3JhZGl1cxgNIAEoAVIKYmFsbFJh'
    'ZGl1cw==');

@$core.Deprecated('Use gameStateDescriptor instead')
const GameState$json = {
  '1': 'GameState',
  '2': [
    {'1': 'ball_state', '3': 1, '4': 1, '5': 11, '6': '.BallState', '10': 'ballState'},
    {'1': 'visible_walls_state', '3': 2, '4': 1, '5': 11, '6': '.VisibleWallsState', '10': 'visibleWallsState'},
    {'1': 'collided_wall', '3': 3, '4': 1, '5': 11, '6': '.Wall', '10': 'collidedWall'},
    {'1': 'time', '3': 4, '4': 1, '5': 1, '10': 'time'},
  ],
};

/// Descriptor for `GameState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gameStateDescriptor = $convert.base64Decode(
    'CglHYW1lU3RhdGUSKQoKYmFsbF9zdGF0ZRgBIAEoCzIKLkJhbGxTdGF0ZVIJYmFsbFN0YXRlEk'
    'IKE3Zpc2libGVfd2FsbHNfc3RhdGUYAiABKAsyEi5WaXNpYmxlV2FsbHNTdGF0ZVIRdmlzaWJs'
    'ZVdhbGxzU3RhdGUSKgoNY29sbGlkZWRfd2FsbBgDIAEoCzIFLldhbGxSDGNvbGxpZGVkV2FsbB'
    'ISCgR0aW1lGAQgASgBUgR0aW1l');

@$core.Deprecated('Use ballStateDescriptor instead')
const BallState$json = {
  '1': 'BallState',
  '2': [
    {'1': 'x', '3': 1, '4': 1, '5': 1, '10': 'x'},
    {'1': 'y', '3': 2, '4': 1, '5': 1, '10': 'y'},
    {'1': 'v', '3': 3, '4': 1, '5': 1, '10': 'v'},
    {'1': 'a', '3': 4, '4': 1, '5': 1, '10': 'a'},
  ],
};

/// Descriptor for `BallState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ballStateDescriptor = $convert.base64Decode(
    'CglCYWxsU3RhdGUSDAoBeBgBIAEoAVIBeBIMCgF5GAIgASgBUgF5EgwKAXYYAyABKAFSAXYSDA'
    'oBYRgEIAEoAVIBYQ==');

@$core.Deprecated('Use visibleWallsStateDescriptor instead')
const VisibleWallsState$json = {
  '1': 'VisibleWallsState',
  '2': [
    {'1': 'walls', '3': 1, '4': 3, '5': 11, '6': '.Wall', '10': 'walls'},
  ],
};

/// Descriptor for `VisibleWallsState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List visibleWallsStateDescriptor = $convert.base64Decode(
    'ChFWaXNpYmxlV2FsbHNTdGF0ZRIbCgV3YWxscxgBIAMoCzIFLldhbGxSBXdhbGxz');

@$core.Deprecated('Use wallDescriptor instead')
const Wall$json = {
  '1': 'Wall',
  '2': [
    {'1': 'x', '3': 1, '4': 1, '5': 1, '10': 'x'},
    {'1': 'y', '3': 2, '4': 1, '5': 1, '10': 'y'},
    {'1': 'width', '3': 3, '4': 1, '5': 1, '10': 'width'},
    {'1': 'height', '3': 4, '4': 1, '5': 1, '10': 'height'},
    {'1': 'points', '3': 5, '4': 1, '5': 1, '10': 'points'},
  ],
};

/// Descriptor for `Wall`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List wallDescriptor = $convert.base64Decode(
    'CgRXYWxsEgwKAXgYASABKAFSAXgSDAoBeRgCIAEoAVIBeRIUCgV3aWR0aBgDIAEoAVIFd2lkdG'
    'gSFgoGaGVpZ2h0GAQgASgBUgZoZWlnaHQSFgoGcG9pbnRzGAUgASgBUgZwb2ludHM=');

@$core.Deprecated('Use stepGameRequestDescriptor instead')
const StepGameRequest$json = {
  '1': 'StepGameRequest',
  '2': [
    {'1': 'should_jump', '3': 1, '4': 1, '5': 8, '10': 'shouldJump'},
  ],
};

/// Descriptor for `StepGameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stepGameRequestDescriptor = $convert.base64Decode(
    'Cg9TdGVwR2FtZVJlcXVlc3QSHwoLc2hvdWxkX2p1bXAYASABKAhSCnNob3VsZEp1bXA=');

@$core.Deprecated('Use stepGameResponseDescriptor instead')
const StepGameResponse$json = {
  '1': 'StepGameResponse',
  '2': [
    {'1': 'game_state', '3': 1, '4': 1, '5': 11, '6': '.GameState', '10': 'gameState'},
    {'1': 'game_over', '3': 2, '4': 1, '5': 8, '10': 'gameOver'},
    {'1': 'reward', '3': 3, '4': 1, '5': 1, '10': 'reward'},
    {'1': 'penalty', '3': 4, '4': 1, '5': 1, '10': 'penalty'},
    {'1': 'score', '3': 5, '4': 1, '5': 1, '10': 'score'},
  ],
};

/// Descriptor for `StepGameResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stepGameResponseDescriptor = $convert.base64Decode(
    'ChBTdGVwR2FtZVJlc3BvbnNlEikKCmdhbWVfc3RhdGUYASABKAsyCi5HYW1lU3RhdGVSCWdhbW'
    'VTdGF0ZRIbCglnYW1lX292ZXIYAiABKAhSCGdhbWVPdmVyEhYKBnJld2FyZBgDIAEoAVIGcmV3'
    'YXJkEhgKB3BlbmFsdHkYBCABKAFSB3BlbmFsdHkSFAoFc2NvcmUYBSABKAFSBXNjb3Jl');

const $core.Map<$core.String, $core.dynamic> RLServerServiceBase$json = {
  '1': 'RLServer',
  '2': [
    {'1': 'CreateNewGame', '2': '.CreateNewGameRequest', '3': '.CreateNewGameResponse', '4': {}},
    {'1': 'StepGame', '2': '.StepGameRequest', '3': '.StepGameResponse', '4': {}},
  ],
};

@$core.Deprecated('Use rLServerServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> RLServerServiceBase$messageJson = {
  '.CreateNewGameRequest': CreateNewGameRequest$json,
  '.CreateNewGameResponse': CreateNewGameResponse$json,
  '.GameWorldBounds': GameWorldBounds$json,
  '.DifficultyParams': DifficultyParams$json,
  '.GameState': GameState$json,
  '.BallState': BallState$json,
  '.VisibleWallsState': VisibleWallsState$json,
  '.Wall': Wall$json,
  '.StepGameRequest': StepGameRequest$json,
  '.StepGameResponse': StepGameResponse$json,
};

/// Descriptor for `RLServer`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List rLServerServiceDescriptor = $convert.base64Decode(
    'CghSTFNlcnZlchJACg1DcmVhdGVOZXdHYW1lEhUuQ3JlYXRlTmV3R2FtZVJlcXVlc3QaFi5Dcm'
    'VhdGVOZXdHYW1lUmVzcG9uc2UiABIxCghTdGVwR2FtZRIQLlN0ZXBHYW1lUmVxdWVzdBoRLlN0'
    'ZXBHYW1lUmVzcG9uc2UiAA==');

