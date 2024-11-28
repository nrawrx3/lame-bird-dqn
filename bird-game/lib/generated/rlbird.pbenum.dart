//
//  Generated code. Do not modify.
//  source: rlbird.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Command_CommandType extends $pb.ProtobufEnum {
  static const Command_CommandType NOOP = Command_CommandType._(0, _omitEnumNames ? '' : 'NOOP');
  static const Command_CommandType ACTION_JUMP = Command_CommandType._(1, _omitEnumNames ? '' : 'ACTION_JUMP');
  static const Command_CommandType CREATE_NEW_GAME = Command_CommandType._(2, _omitEnumNames ? '' : 'CREATE_NEW_GAME');

  static const $core.List<Command_CommandType> values = <Command_CommandType> [
    NOOP,
    ACTION_JUMP,
    CREATE_NEW_GAME,
  ];

  static final $core.Map<$core.int, Command_CommandType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Command_CommandType? valueOf($core.int value) => _byValue[value];

  const Command_CommandType._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
