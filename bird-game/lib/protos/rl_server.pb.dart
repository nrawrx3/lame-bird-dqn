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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class CreateNewGameRequest extends $pb.GeneratedMessage {
  factory CreateNewGameRequest({
    $fixnum.Int64? seed,
    $fixnum.Int64? maxWalls,
  }) {
    final $result = create();
    if (seed != null) {
      $result.seed = seed;
    }
    if (maxWalls != null) {
      $result.maxWalls = maxWalls;
    }
    return $result;
  }
  CreateNewGameRequest._() : super();
  factory CreateNewGameRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateNewGameRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateNewGameRequest', createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'seed')
    ..aInt64(2, _omitFieldNames ? '' : 'maxWalls')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateNewGameRequest clone() => CreateNewGameRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateNewGameRequest copyWith(void Function(CreateNewGameRequest) updates) => super.copyWith((message) => updates(message as CreateNewGameRequest)) as CreateNewGameRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateNewGameRequest create() => CreateNewGameRequest._();
  CreateNewGameRequest createEmptyInstance() => create();
  static $pb.PbList<CreateNewGameRequest> createRepeated() => $pb.PbList<CreateNewGameRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateNewGameRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateNewGameRequest>(create);
  static CreateNewGameRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get seed => $_getI64(0);
  @$pb.TagNumber(1)
  set seed($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSeed() => $_has(0);
  @$pb.TagNumber(1)
  void clearSeed() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get maxWalls => $_getI64(1);
  @$pb.TagNumber(2)
  set maxWalls($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMaxWalls() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaxWalls() => clearField(2);
}

class CreateNewGameResponse extends $pb.GeneratedMessage {
  factory CreateNewGameResponse({
    GameWorldBounds? gameWorldBounds,
    DifficultyParams? difficultyParams,
    GameState? gameState,
  }) {
    final $result = create();
    if (gameWorldBounds != null) {
      $result.gameWorldBounds = gameWorldBounds;
    }
    if (difficultyParams != null) {
      $result.difficultyParams = difficultyParams;
    }
    if (gameState != null) {
      $result.gameState = gameState;
    }
    return $result;
  }
  CreateNewGameResponse._() : super();
  factory CreateNewGameResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateNewGameResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateNewGameResponse', createEmptyInstance: create)
    ..aOM<GameWorldBounds>(1, _omitFieldNames ? '' : 'gameWorldBounds', subBuilder: GameWorldBounds.create)
    ..aOM<DifficultyParams>(2, _omitFieldNames ? '' : 'difficultyParams', subBuilder: DifficultyParams.create)
    ..aOM<GameState>(3, _omitFieldNames ? '' : 'gameState', subBuilder: GameState.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateNewGameResponse clone() => CreateNewGameResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateNewGameResponse copyWith(void Function(CreateNewGameResponse) updates) => super.copyWith((message) => updates(message as CreateNewGameResponse)) as CreateNewGameResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateNewGameResponse create() => CreateNewGameResponse._();
  CreateNewGameResponse createEmptyInstance() => create();
  static $pb.PbList<CreateNewGameResponse> createRepeated() => $pb.PbList<CreateNewGameResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateNewGameResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateNewGameResponse>(create);
  static CreateNewGameResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GameWorldBounds get gameWorldBounds => $_getN(0);
  @$pb.TagNumber(1)
  set gameWorldBounds(GameWorldBounds v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGameWorldBounds() => $_has(0);
  @$pb.TagNumber(1)
  void clearGameWorldBounds() => clearField(1);
  @$pb.TagNumber(1)
  GameWorldBounds ensureGameWorldBounds() => $_ensure(0);

  @$pb.TagNumber(2)
  DifficultyParams get difficultyParams => $_getN(1);
  @$pb.TagNumber(2)
  set difficultyParams(DifficultyParams v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasDifficultyParams() => $_has(1);
  @$pb.TagNumber(2)
  void clearDifficultyParams() => clearField(2);
  @$pb.TagNumber(2)
  DifficultyParams ensureDifficultyParams() => $_ensure(1);

  @$pb.TagNumber(3)
  GameState get gameState => $_getN(2);
  @$pb.TagNumber(3)
  set gameState(GameState v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasGameState() => $_has(2);
  @$pb.TagNumber(3)
  void clearGameState() => clearField(3);
  @$pb.TagNumber(3)
  GameState ensureGameState() => $_ensure(2);
}

class GameWorldBounds extends $pb.GeneratedMessage {
  factory GameWorldBounds({
    $core.double? viewWidth,
    $core.double? viewHeight,
    $core.double? minWallGap,
  }) {
    final $result = create();
    if (viewWidth != null) {
      $result.viewWidth = viewWidth;
    }
    if (viewHeight != null) {
      $result.viewHeight = viewHeight;
    }
    if (minWallGap != null) {
      $result.minWallGap = minWallGap;
    }
    return $result;
  }
  GameWorldBounds._() : super();
  factory GameWorldBounds.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GameWorldBounds.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GameWorldBounds', createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'viewWidth', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'viewHeight', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'minWallGap', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GameWorldBounds clone() => GameWorldBounds()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GameWorldBounds copyWith(void Function(GameWorldBounds) updates) => super.copyWith((message) => updates(message as GameWorldBounds)) as GameWorldBounds;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GameWorldBounds create() => GameWorldBounds._();
  GameWorldBounds createEmptyInstance() => create();
  static $pb.PbList<GameWorldBounds> createRepeated() => $pb.PbList<GameWorldBounds>();
  @$core.pragma('dart2js:noInline')
  static GameWorldBounds getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GameWorldBounds>(create);
  static GameWorldBounds? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get viewWidth => $_getN(0);
  @$pb.TagNumber(1)
  set viewWidth($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasViewWidth() => $_has(0);
  @$pb.TagNumber(1)
  void clearViewWidth() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get viewHeight => $_getN(1);
  @$pb.TagNumber(2)
  set viewHeight($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasViewHeight() => $_has(1);
  @$pb.TagNumber(2)
  void clearViewHeight() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get minWallGap => $_getN(2);
  @$pb.TagNumber(3)
  set minWallGap($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMinWallGap() => $_has(2);
  @$pb.TagNumber(3)
  void clearMinWallGap() => clearField(3);
}

/// The model training does not care about these parameters except the pentalty.
/// We're sending these to the Python client just to create logs.
class DifficultyParams extends $pb.GeneratedMessage {
  factory DifficultyParams({
    $core.double? ballMaxVelocity,
    $core.double? ballStartingVelocity,
    $core.bool? disableCameraTilt,
    $core.double? ballNudgeVelocity,
    $core.double? noiseScale,
    $core.double? g,
    $core.double? badWallInvisibleProbability,
    $core.double? maxWallHeight,
    $core.double? minWallHeight,
    $core.int? badWallPenalty,
    $core.double? maxWallWidth,
    $core.double? minWallWidth,
    $core.double? ballRadius,
  }) {
    final $result = create();
    if (ballMaxVelocity != null) {
      $result.ballMaxVelocity = ballMaxVelocity;
    }
    if (ballStartingVelocity != null) {
      $result.ballStartingVelocity = ballStartingVelocity;
    }
    if (disableCameraTilt != null) {
      $result.disableCameraTilt = disableCameraTilt;
    }
    if (ballNudgeVelocity != null) {
      $result.ballNudgeVelocity = ballNudgeVelocity;
    }
    if (noiseScale != null) {
      $result.noiseScale = noiseScale;
    }
    if (g != null) {
      $result.g = g;
    }
    if (badWallInvisibleProbability != null) {
      $result.badWallInvisibleProbability = badWallInvisibleProbability;
    }
    if (maxWallHeight != null) {
      $result.maxWallHeight = maxWallHeight;
    }
    if (minWallHeight != null) {
      $result.minWallHeight = minWallHeight;
    }
    if (badWallPenalty != null) {
      $result.badWallPenalty = badWallPenalty;
    }
    if (maxWallWidth != null) {
      $result.maxWallWidth = maxWallWidth;
    }
    if (minWallWidth != null) {
      $result.minWallWidth = minWallWidth;
    }
    if (ballRadius != null) {
      $result.ballRadius = ballRadius;
    }
    return $result;
  }
  DifficultyParams._() : super();
  factory DifficultyParams.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DifficultyParams.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DifficultyParams', createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'ballMaxVelocity', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'ballStartingVelocity', $pb.PbFieldType.OD)
    ..aOB(3, _omitFieldNames ? '' : 'disableCameraTilt')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'ballNudgeVelocity', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'noiseScale', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'g', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'badWallInvisibleProbability', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'maxWallHeight', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'minWallHeight', $pb.PbFieldType.OD)
    ..a<$core.int>(10, _omitFieldNames ? '' : 'badWallPenalty', $pb.PbFieldType.O3)
    ..a<$core.double>(11, _omitFieldNames ? '' : 'maxWallWidth', $pb.PbFieldType.OD)
    ..a<$core.double>(12, _omitFieldNames ? '' : 'minWallWidth', $pb.PbFieldType.OD)
    ..a<$core.double>(13, _omitFieldNames ? '' : 'ballRadius', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DifficultyParams clone() => DifficultyParams()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DifficultyParams copyWith(void Function(DifficultyParams) updates) => super.copyWith((message) => updates(message as DifficultyParams)) as DifficultyParams;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DifficultyParams create() => DifficultyParams._();
  DifficultyParams createEmptyInstance() => create();
  static $pb.PbList<DifficultyParams> createRepeated() => $pb.PbList<DifficultyParams>();
  @$core.pragma('dart2js:noInline')
  static DifficultyParams getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DifficultyParams>(create);
  static DifficultyParams? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get ballMaxVelocity => $_getN(0);
  @$pb.TagNumber(1)
  set ballMaxVelocity($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBallMaxVelocity() => $_has(0);
  @$pb.TagNumber(1)
  void clearBallMaxVelocity() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get ballStartingVelocity => $_getN(1);
  @$pb.TagNumber(2)
  set ballStartingVelocity($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBallStartingVelocity() => $_has(1);
  @$pb.TagNumber(2)
  void clearBallStartingVelocity() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get disableCameraTilt => $_getBF(2);
  @$pb.TagNumber(3)
  set disableCameraTilt($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDisableCameraTilt() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisableCameraTilt() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get ballNudgeVelocity => $_getN(3);
  @$pb.TagNumber(4)
  set ballNudgeVelocity($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBallNudgeVelocity() => $_has(3);
  @$pb.TagNumber(4)
  void clearBallNudgeVelocity() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get noiseScale => $_getN(4);
  @$pb.TagNumber(5)
  set noiseScale($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNoiseScale() => $_has(4);
  @$pb.TagNumber(5)
  void clearNoiseScale() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get g => $_getN(5);
  @$pb.TagNumber(6)
  set g($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasG() => $_has(5);
  @$pb.TagNumber(6)
  void clearG() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get badWallInvisibleProbability => $_getN(6);
  @$pb.TagNumber(7)
  set badWallInvisibleProbability($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasBadWallInvisibleProbability() => $_has(6);
  @$pb.TagNumber(7)
  void clearBadWallInvisibleProbability() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get maxWallHeight => $_getN(7);
  @$pb.TagNumber(8)
  set maxWallHeight($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMaxWallHeight() => $_has(7);
  @$pb.TagNumber(8)
  void clearMaxWallHeight() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get minWallHeight => $_getN(8);
  @$pb.TagNumber(9)
  set minWallHeight($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasMinWallHeight() => $_has(8);
  @$pb.TagNumber(9)
  void clearMinWallHeight() => clearField(9);

  @$pb.TagNumber(10)
  $core.int get badWallPenalty => $_getIZ(9);
  @$pb.TagNumber(10)
  set badWallPenalty($core.int v) { $_setSignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasBadWallPenalty() => $_has(9);
  @$pb.TagNumber(10)
  void clearBadWallPenalty() => clearField(10);

  @$pb.TagNumber(11)
  $core.double get maxWallWidth => $_getN(10);
  @$pb.TagNumber(11)
  set maxWallWidth($core.double v) { $_setDouble(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasMaxWallWidth() => $_has(10);
  @$pb.TagNumber(11)
  void clearMaxWallWidth() => clearField(11);

  @$pb.TagNumber(12)
  $core.double get minWallWidth => $_getN(11);
  @$pb.TagNumber(12)
  set minWallWidth($core.double v) { $_setDouble(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasMinWallWidth() => $_has(11);
  @$pb.TagNumber(12)
  void clearMinWallWidth() => clearField(12);

  @$pb.TagNumber(13)
  $core.double get ballRadius => $_getN(12);
  @$pb.TagNumber(13)
  set ballRadius($core.double v) { $_setDouble(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasBallRadius() => $_has(12);
  @$pb.TagNumber(13)
  void clearBallRadius() => clearField(13);
}

class GameState extends $pb.GeneratedMessage {
  factory GameState({
    BallState? ballState,
    VisibleWallsState? visibleWallsState,
    $core.Iterable<WallCollision>? wallCollisions,
    $core.double? time,
  }) {
    final $result = create();
    if (ballState != null) {
      $result.ballState = ballState;
    }
    if (visibleWallsState != null) {
      $result.visibleWallsState = visibleWallsState;
    }
    if (wallCollisions != null) {
      $result.wallCollisions.addAll(wallCollisions);
    }
    if (time != null) {
      $result.time = time;
    }
    return $result;
  }
  GameState._() : super();
  factory GameState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GameState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GameState', createEmptyInstance: create)
    ..aOM<BallState>(1, _omitFieldNames ? '' : 'ballState', subBuilder: BallState.create)
    ..aOM<VisibleWallsState>(2, _omitFieldNames ? '' : 'visibleWallsState', subBuilder: VisibleWallsState.create)
    ..pc<WallCollision>(3, _omitFieldNames ? '' : 'wallCollisions', $pb.PbFieldType.PM, subBuilder: WallCollision.create)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'time', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GameState clone() => GameState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GameState copyWith(void Function(GameState) updates) => super.copyWith((message) => updates(message as GameState)) as GameState;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GameState create() => GameState._();
  GameState createEmptyInstance() => create();
  static $pb.PbList<GameState> createRepeated() => $pb.PbList<GameState>();
  @$core.pragma('dart2js:noInline')
  static GameState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GameState>(create);
  static GameState? _defaultInstance;

  @$pb.TagNumber(1)
  BallState get ballState => $_getN(0);
  @$pb.TagNumber(1)
  set ballState(BallState v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasBallState() => $_has(0);
  @$pb.TagNumber(1)
  void clearBallState() => clearField(1);
  @$pb.TagNumber(1)
  BallState ensureBallState() => $_ensure(0);

  @$pb.TagNumber(2)
  VisibleWallsState get visibleWallsState => $_getN(1);
  @$pb.TagNumber(2)
  set visibleWallsState(VisibleWallsState v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasVisibleWallsState() => $_has(1);
  @$pb.TagNumber(2)
  void clearVisibleWallsState() => clearField(2);
  @$pb.TagNumber(2)
  VisibleWallsState ensureVisibleWallsState() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.List<WallCollision> get wallCollisions => $_getList(2);

  @$pb.TagNumber(4)
  $core.double get time => $_getN(3);
  @$pb.TagNumber(4)
  set time($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearTime() => clearField(4);
}

class WallCollision extends $pb.GeneratedMessage {
  factory WallCollision({
    Wall? wall,
    BallState? ballState,
  }) {
    final $result = create();
    if (wall != null) {
      $result.wall = wall;
    }
    if (ballState != null) {
      $result.ballState = ballState;
    }
    return $result;
  }
  WallCollision._() : super();
  factory WallCollision.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WallCollision.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WallCollision', createEmptyInstance: create)
    ..aOM<Wall>(1, _omitFieldNames ? '' : 'wall', subBuilder: Wall.create)
    ..aOM<BallState>(2, _omitFieldNames ? '' : 'ballState', subBuilder: BallState.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WallCollision clone() => WallCollision()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WallCollision copyWith(void Function(WallCollision) updates) => super.copyWith((message) => updates(message as WallCollision)) as WallCollision;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WallCollision create() => WallCollision._();
  WallCollision createEmptyInstance() => create();
  static $pb.PbList<WallCollision> createRepeated() => $pb.PbList<WallCollision>();
  @$core.pragma('dart2js:noInline')
  static WallCollision getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WallCollision>(create);
  static WallCollision? _defaultInstance;

  @$pb.TagNumber(1)
  Wall get wall => $_getN(0);
  @$pb.TagNumber(1)
  set wall(Wall v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasWall() => $_has(0);
  @$pb.TagNumber(1)
  void clearWall() => clearField(1);
  @$pb.TagNumber(1)
  Wall ensureWall() => $_ensure(0);

  @$pb.TagNumber(2)
  BallState get ballState => $_getN(1);
  @$pb.TagNumber(2)
  set ballState(BallState v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasBallState() => $_has(1);
  @$pb.TagNumber(2)
  void clearBallState() => clearField(2);
  @$pb.TagNumber(2)
  BallState ensureBallState() => $_ensure(1);
}

class BallState extends $pb.GeneratedMessage {
  factory BallState({
    $core.double? x,
    $core.double? y,
    $core.double? vx,
    $core.double? vy,
    $core.double? ax,
    $core.double? ay,
  }) {
    final $result = create();
    if (x != null) {
      $result.x = x;
    }
    if (y != null) {
      $result.y = y;
    }
    if (vx != null) {
      $result.vx = vx;
    }
    if (vy != null) {
      $result.vy = vy;
    }
    if (ax != null) {
      $result.ax = ax;
    }
    if (ay != null) {
      $result.ay = ay;
    }
    return $result;
  }
  BallState._() : super();
  factory BallState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BallState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BallState', createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'x', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'y', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'vx', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'vy', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'ax', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'ay', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BallState clone() => BallState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BallState copyWith(void Function(BallState) updates) => super.copyWith((message) => updates(message as BallState)) as BallState;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BallState create() => BallState._();
  BallState createEmptyInstance() => create();
  static $pb.PbList<BallState> createRepeated() => $pb.PbList<BallState>();
  @$core.pragma('dart2js:noInline')
  static BallState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BallState>(create);
  static BallState? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get x => $_getN(0);
  @$pb.TagNumber(1)
  set x($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasX() => $_has(0);
  @$pb.TagNumber(1)
  void clearX() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get y => $_getN(1);
  @$pb.TagNumber(2)
  set y($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasY() => $_has(1);
  @$pb.TagNumber(2)
  void clearY() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get vx => $_getN(2);
  @$pb.TagNumber(3)
  set vx($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVx() => $_has(2);
  @$pb.TagNumber(3)
  void clearVx() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get vy => $_getN(3);
  @$pb.TagNumber(4)
  set vy($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasVy() => $_has(3);
  @$pb.TagNumber(4)
  void clearVy() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get ax => $_getN(4);
  @$pb.TagNumber(5)
  set ax($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAx() => $_has(4);
  @$pb.TagNumber(5)
  void clearAx() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get ay => $_getN(5);
  @$pb.TagNumber(6)
  set ay($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAy() => $_has(5);
  @$pb.TagNumber(6)
  void clearAy() => clearField(6);
}

class VisibleWallsState extends $pb.GeneratedMessage {
  factory VisibleWallsState({
    $core.Iterable<Wall>? walls,
  }) {
    final $result = create();
    if (walls != null) {
      $result.walls.addAll(walls);
    }
    return $result;
  }
  VisibleWallsState._() : super();
  factory VisibleWallsState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VisibleWallsState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VisibleWallsState', createEmptyInstance: create)
    ..pc<Wall>(1, _omitFieldNames ? '' : 'walls', $pb.PbFieldType.PM, subBuilder: Wall.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VisibleWallsState clone() => VisibleWallsState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VisibleWallsState copyWith(void Function(VisibleWallsState) updates) => super.copyWith((message) => updates(message as VisibleWallsState)) as VisibleWallsState;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VisibleWallsState create() => VisibleWallsState._();
  VisibleWallsState createEmptyInstance() => create();
  static $pb.PbList<VisibleWallsState> createRepeated() => $pb.PbList<VisibleWallsState>();
  @$core.pragma('dart2js:noInline')
  static VisibleWallsState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VisibleWallsState>(create);
  static VisibleWallsState? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Wall> get walls => $_getList(0);
}

class Wall extends $pb.GeneratedMessage {
  factory Wall({
    $core.double? x,
    $core.double? y,
    $core.double? width,
    $core.double? height,
    $core.double? points,
  }) {
    final $result = create();
    if (x != null) {
      $result.x = x;
    }
    if (y != null) {
      $result.y = y;
    }
    if (width != null) {
      $result.width = width;
    }
    if (height != null) {
      $result.height = height;
    }
    if (points != null) {
      $result.points = points;
    }
    return $result;
  }
  Wall._() : super();
  factory Wall.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Wall.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Wall', createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'x', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'y', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'width', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'height', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'points', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Wall clone() => Wall()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Wall copyWith(void Function(Wall) updates) => super.copyWith((message) => updates(message as Wall)) as Wall;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Wall create() => Wall._();
  Wall createEmptyInstance() => create();
  static $pb.PbList<Wall> createRepeated() => $pb.PbList<Wall>();
  @$core.pragma('dart2js:noInline')
  static Wall getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Wall>(create);
  static Wall? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get x => $_getN(0);
  @$pb.TagNumber(1)
  set x($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasX() => $_has(0);
  @$pb.TagNumber(1)
  void clearX() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get y => $_getN(1);
  @$pb.TagNumber(2)
  set y($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasY() => $_has(1);
  @$pb.TagNumber(2)
  void clearY() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get width => $_getN(2);
  @$pb.TagNumber(3)
  set width($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasWidth() => $_has(2);
  @$pb.TagNumber(3)
  void clearWidth() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get height => $_getN(3);
  @$pb.TagNumber(4)
  set height($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasHeight() => $_has(3);
  @$pb.TagNumber(4)
  void clearHeight() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get points => $_getN(4);
  @$pb.TagNumber(5)
  set points($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPoints() => $_has(4);
  @$pb.TagNumber(5)
  void clearPoints() => clearField(5);
}

class StepGameRequest extends $pb.GeneratedMessage {
  factory StepGameRequest({
    $core.bool? shouldJump,
  }) {
    final $result = create();
    if (shouldJump != null) {
      $result.shouldJump = shouldJump;
    }
    return $result;
  }
  StepGameRequest._() : super();
  factory StepGameRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StepGameRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StepGameRequest', createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'shouldJump')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StepGameRequest clone() => StepGameRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StepGameRequest copyWith(void Function(StepGameRequest) updates) => super.copyWith((message) => updates(message as StepGameRequest)) as StepGameRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StepGameRequest create() => StepGameRequest._();
  StepGameRequest createEmptyInstance() => create();
  static $pb.PbList<StepGameRequest> createRepeated() => $pb.PbList<StepGameRequest>();
  @$core.pragma('dart2js:noInline')
  static StepGameRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StepGameRequest>(create);
  static StepGameRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get shouldJump => $_getBF(0);
  @$pb.TagNumber(1)
  set shouldJump($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasShouldJump() => $_has(0);
  @$pb.TagNumber(1)
  void clearShouldJump() => clearField(1);
}

class StepGameResponse extends $pb.GeneratedMessage {
  factory StepGameResponse({
    GameState? gameState,
    $core.bool? gameOver,
    $core.double? reward,
    $core.double? penalty,
    $core.double? score,
  }) {
    final $result = create();
    if (gameState != null) {
      $result.gameState = gameState;
    }
    if (gameOver != null) {
      $result.gameOver = gameOver;
    }
    if (reward != null) {
      $result.reward = reward;
    }
    if (penalty != null) {
      $result.penalty = penalty;
    }
    if (score != null) {
      $result.score = score;
    }
    return $result;
  }
  StepGameResponse._() : super();
  factory StepGameResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StepGameResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StepGameResponse', createEmptyInstance: create)
    ..aOM<GameState>(1, _omitFieldNames ? '' : 'gameState', subBuilder: GameState.create)
    ..aOB(2, _omitFieldNames ? '' : 'gameOver')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'reward', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'penalty', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'score', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StepGameResponse clone() => StepGameResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StepGameResponse copyWith(void Function(StepGameResponse) updates) => super.copyWith((message) => updates(message as StepGameResponse)) as StepGameResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StepGameResponse create() => StepGameResponse._();
  StepGameResponse createEmptyInstance() => create();
  static $pb.PbList<StepGameResponse> createRepeated() => $pb.PbList<StepGameResponse>();
  @$core.pragma('dart2js:noInline')
  static StepGameResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StepGameResponse>(create);
  static StepGameResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GameState get gameState => $_getN(0);
  @$pb.TagNumber(1)
  set gameState(GameState v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGameState() => $_has(0);
  @$pb.TagNumber(1)
  void clearGameState() => clearField(1);
  @$pb.TagNumber(1)
  GameState ensureGameState() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get gameOver => $_getBF(1);
  @$pb.TagNumber(2)
  set gameOver($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasGameOver() => $_has(1);
  @$pb.TagNumber(2)
  void clearGameOver() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get reward => $_getN(2);
  @$pb.TagNumber(3)
  set reward($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReward() => $_has(2);
  @$pb.TagNumber(3)
  void clearReward() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get penalty => $_getN(3);
  @$pb.TagNumber(4)
  set penalty($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPenalty() => $_has(3);
  @$pb.TagNumber(4)
  void clearPenalty() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get score => $_getN(4);
  @$pb.TagNumber(5)
  set score($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasScore() => $_has(4);
  @$pb.TagNumber(5)
  void clearScore() => clearField(5);
}

class RLServerApi {
  $pb.RpcClient _client;
  RLServerApi(this._client);

  $async.Future<CreateNewGameResponse> createNewGame($pb.ClientContext? ctx, CreateNewGameRequest request) =>
    _client.invoke<CreateNewGameResponse>(ctx, 'RLServer', 'CreateNewGame', request, CreateNewGameResponse())
  ;
  $async.Future<StepGameResponse> stepGame($pb.ClientContext? ctx, StepGameRequest request) =>
    _client.invoke<StepGameResponse>(ctx, 'RLServer', 'StepGame', request, StepGameResponse())
  ;
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
