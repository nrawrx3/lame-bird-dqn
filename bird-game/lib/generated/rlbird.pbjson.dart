//
//  Generated code. Do not modify.
//  source: rlbird.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use getNextCommandRequestDescriptor instead')
const GetNextCommandRequest$json = {
  '1': 'GetNextCommandRequest',
};

/// Descriptor for `GetNextCommandRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getNextCommandRequestDescriptor = $convert.base64Decode(
    'ChVHZXROZXh0Q29tbWFuZFJlcXVlc3Q=');

@$core.Deprecated('Use setCommandResultRequestDescriptor instead')
const SetCommandResultRequest$json = {
  '1': 'SetCommandResultRequest',
  '2': [
    {'1': 'command_result', '3': 1, '4': 1, '5': 11, '6': '.rlbird.CommandResult', '10': 'commandResult'},
  ],
};

/// Descriptor for `SetCommandResultRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setCommandResultRequestDescriptor = $convert.base64Decode(
    'ChdTZXRDb21tYW5kUmVzdWx0UmVxdWVzdBI8Cg5jb21tYW5kX3Jlc3VsdBgBIAEoCzIVLnJsYm'
    'lyZC5Db21tYW5kUmVzdWx0Ug1jb21tYW5kUmVzdWx0');

@$core.Deprecated('Use setCommandResultResponseDescriptor instead')
const SetCommandResultResponse$json = {
  '1': 'SetCommandResultResponse',
};

/// Descriptor for `SetCommandResultResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setCommandResultResponseDescriptor = $convert.base64Decode(
    'ChhTZXRDb21tYW5kUmVzdWx0UmVzcG9uc2U=');

@$core.Deprecated('Use commandDescriptor instead')
const Command$json = {
  '1': 'Command',
  '2': [
    {'1': 'command_type', '3': 1, '4': 1, '5': 14, '6': '.rlbird.Command.CommandType', '10': 'commandType'},
    {'1': 'action_jump_command', '3': 2, '4': 1, '5': 11, '6': '.rlbird.ActionJumpCommandData', '9': 0, '10': 'actionJumpCommand'},
    {'1': 'create_new_game_command', '3': 3, '4': 1, '5': 11, '6': '.rlbird.CreateNewGameCommandData', '9': 0, '10': 'createNewGameCommand'},
  ],
  '4': [Command_CommandType$json],
  '8': [
    {'1': 'data'},
  ],
};

@$core.Deprecated('Use commandDescriptor instead')
const Command_CommandType$json = {
  '1': 'CommandType',
  '2': [
    {'1': 'NOOP', '2': 0},
    {'1': 'ACTION_JUMP', '2': 1},
    {'1': 'CREATE_NEW_GAME', '2': 2},
  ],
};

/// Descriptor for `Command`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commandDescriptor = $convert.base64Decode(
    'CgdDb21tYW5kEj4KDGNvbW1hbmRfdHlwZRgBIAEoDjIbLnJsYmlyZC5Db21tYW5kLkNvbW1hbm'
    'RUeXBlUgtjb21tYW5kVHlwZRJPChNhY3Rpb25fanVtcF9jb21tYW5kGAIgASgLMh0ucmxiaXJk'
    'LkFjdGlvbkp1bXBDb21tYW5kRGF0YUgAUhFhY3Rpb25KdW1wQ29tbWFuZBJZChdjcmVhdGVfbm'
    'V3X2dhbWVfY29tbWFuZBgDIAEoCzIgLnJsYmlyZC5DcmVhdGVOZXdHYW1lQ29tbWFuZERhdGFI'
    'AFIUY3JlYXRlTmV3R2FtZUNvbW1hbmQiPQoLQ29tbWFuZFR5cGUSCAoETk9PUBAAEg8KC0FDVE'
    'lPTl9KVU1QEAESEwoPQ1JFQVRFX05FV19HQU1FEAJCBgoEZGF0YQ==');

@$core.Deprecated('Use createNewGameCommandDataDescriptor instead')
const CreateNewGameCommandData$json = {
  '1': 'CreateNewGameCommandData',
  '2': [
    {'1': 'game_world_bounds', '3': 1, '4': 1, '5': 11, '6': '.rlbird.GameWorldBounds', '10': 'gameWorldBounds'},
    {'1': 'difficulty_params', '3': 2, '4': 1, '5': 11, '6': '.rlbird.DifficultyParams', '10': 'difficultyParams'},
  ],
};

/// Descriptor for `CreateNewGameCommandData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createNewGameCommandDataDescriptor = $convert.base64Decode(
    'ChhDcmVhdGVOZXdHYW1lQ29tbWFuZERhdGESQwoRZ2FtZV93b3JsZF9ib3VuZHMYASABKAsyFy'
    '5ybGJpcmQuR2FtZVdvcmxkQm91bmRzUg9nYW1lV29ybGRCb3VuZHMSRQoRZGlmZmljdWx0eV9w'
    'YXJhbXMYAiABKAsyGC5ybGJpcmQuRGlmZmljdWx0eVBhcmFtc1IQZGlmZmljdWx0eVBhcmFtcw'
    '==');

@$core.Deprecated('Use actionJumpCommandDataDescriptor instead')
const ActionJumpCommandData$json = {
  '1': 'ActionJumpCommandData',
  '2': [
    {'1': 'jump_force', '3': 1, '4': 1, '5': 1, '10': 'jumpForce'},
  ],
};

/// Descriptor for `ActionJumpCommandData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List actionJumpCommandDataDescriptor = $convert.base64Decode(
    'ChVBY3Rpb25KdW1wQ29tbWFuZERhdGESHQoKanVtcF9mb3JjZRgBIAEoAVIJanVtcEZvcmNl');

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
    {'1': 'ball_state', '3': 1, '4': 1, '5': 11, '6': '.rlbird.BallState', '10': 'ballState'},
    {'1': 'visible_walls_state', '3': 2, '4': 1, '5': 11, '6': '.rlbird.VisibleWallsState', '10': 'visibleWallsState'},
    {'1': 'wall_collisions', '3': 3, '4': 3, '5': 11, '6': '.rlbird.WallCollision', '10': 'wallCollisions'},
    {'1': 'time', '3': 4, '4': 1, '5': 1, '10': 'time'},
  ],
};

/// Descriptor for `GameState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gameStateDescriptor = $convert.base64Decode(
    'CglHYW1lU3RhdGUSMAoKYmFsbF9zdGF0ZRgBIAEoCzIRLnJsYmlyZC5CYWxsU3RhdGVSCWJhbG'
    'xTdGF0ZRJJChN2aXNpYmxlX3dhbGxzX3N0YXRlGAIgASgLMhkucmxiaXJkLlZpc2libGVXYWxs'
    'c1N0YXRlUhF2aXNpYmxlV2FsbHNTdGF0ZRI+Cg93YWxsX2NvbGxpc2lvbnMYAyADKAsyFS5ybG'
    'JpcmQuV2FsbENvbGxpc2lvblIOd2FsbENvbGxpc2lvbnMSEgoEdGltZRgEIAEoAVIEdGltZQ==');

@$core.Deprecated('Use wallCollisionDescriptor instead')
const WallCollision$json = {
  '1': 'WallCollision',
  '2': [
    {'1': 'wall', '3': 1, '4': 1, '5': 11, '6': '.rlbird.Wall', '10': 'wall'},
    {'1': 'ball_state', '3': 2, '4': 1, '5': 11, '6': '.rlbird.BallState', '10': 'ballState'},
  ],
};

/// Descriptor for `WallCollision`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List wallCollisionDescriptor = $convert.base64Decode(
    'Cg1XYWxsQ29sbGlzaW9uEiAKBHdhbGwYASABKAsyDC5ybGJpcmQuV2FsbFIEd2FsbBIwCgpiYW'
    'xsX3N0YXRlGAIgASgLMhEucmxiaXJkLkJhbGxTdGF0ZVIJYmFsbFN0YXRl');

@$core.Deprecated('Use ballStateDescriptor instead')
const BallState$json = {
  '1': 'BallState',
  '2': [
    {'1': 'x', '3': 1, '4': 1, '5': 1, '10': 'x'},
    {'1': 'y', '3': 2, '4': 1, '5': 1, '10': 'y'},
    {'1': 'vx', '3': 3, '4': 1, '5': 1, '10': 'vx'},
    {'1': 'vy', '3': 4, '4': 1, '5': 1, '10': 'vy'},
    {'1': 'ax', '3': 5, '4': 1, '5': 1, '10': 'ax'},
    {'1': 'ay', '3': 6, '4': 1, '5': 1, '10': 'ay'},
  ],
};

/// Descriptor for `BallState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ballStateDescriptor = $convert.base64Decode(
    'CglCYWxsU3RhdGUSDAoBeBgBIAEoAVIBeBIMCgF5GAIgASgBUgF5Eg4KAnZ4GAMgASgBUgJ2eB'
    'IOCgJ2eRgEIAEoAVICdnkSDgoCYXgYBSABKAFSAmF4Eg4KAmF5GAYgASgBUgJheQ==');

@$core.Deprecated('Use visibleWallsStateDescriptor instead')
const VisibleWallsState$json = {
  '1': 'VisibleWallsState',
  '2': [
    {'1': 'walls', '3': 1, '4': 3, '5': 11, '6': '.rlbird.Wall', '10': 'walls'},
  ],
};

/// Descriptor for `VisibleWallsState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List visibleWallsStateDescriptor = $convert.base64Decode(
    'ChFWaXNpYmxlV2FsbHNTdGF0ZRIiCgV3YWxscxgBIAMoCzIMLnJsYmlyZC5XYWxsUgV3YWxscw'
    '==');

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

@$core.Deprecated('Use commandResultDescriptor instead')
const CommandResult$json = {
  '1': 'CommandResult',
  '2': [
    {'1': 'game_state', '3': 1, '4': 1, '5': 11, '6': '.rlbird.GameState', '10': 'gameState'},
    {'1': 'game_over', '3': 2, '4': 1, '5': 8, '10': 'gameOver'},
    {'1': 'reward', '3': 3, '4': 1, '5': 1, '10': 'reward'},
  ],
};

/// Descriptor for `CommandResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commandResultDescriptor = $convert.base64Decode(
    'Cg1Db21tYW5kUmVzdWx0EjAKCmdhbWVfc3RhdGUYASABKAsyES5ybGJpcmQuR2FtZVN0YXRlUg'
    'lnYW1lU3RhdGUSGwoJZ2FtZV9vdmVyGAIgASgIUghnYW1lT3ZlchIWCgZyZXdhcmQYAyABKAFS'
    'BnJld2FyZA==');

