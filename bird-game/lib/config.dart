import 'dart:math';

// const worldWidth = 100.0;
// const worldHeight = 100.0;

// The dimensions of the box we're seeing on screen we see at any instant.
const viewWidth = 534.0;
const viewHeight = 300.0;

// const maxWallGap = 10.0;
const minWallGap = 0.2;

const maxWallsInView = 40;

const preventBallOutOfBounds = true;
const disableBallPassThrough = true;
const disableCameraTilt = true;

const maxCameraTilt = 20.0 * pi / 180;

const rlTrainDifficulty = 6;
const goodCollisionReward = 0.0;

const disableRLClient = false;

class DifficultyParams {
  final double ballMaxVelocity;
  final double ballStartingVelocity;
  final bool disableCameraTilt;
  final double ballNudgeVelocity;
  final double noiseScale;
  final double g;
  final double badWallInvisibleProbability;
  final double maxWallHeight;
  final double minWallHeight;
  final int badWallPenalty;
  final int outOfTopBoundsPenalty;
  final double maxWallWidth;
  final double minWallWidth;
  final double maxTravelDistance; // Before the game ends.
  double ballRadius;

  DifficultyParams({
    required this.ballMaxVelocity,
    required this.ballStartingVelocity,
    required this.disableCameraTilt,
    required this.ballNudgeVelocity,
    required this.noiseScale,
    required this.g,
    required this.badWallInvisibleProbability,
    required this.maxWallHeight,
    required this.minWallHeight,
    required this.badWallPenalty,
    required this.outOfTopBoundsPenalty,
    required this.maxWallWidth,
    required this.minWallWidth,
    this.maxTravelDistance = viewWidth * 10,
    this.ballRadius = 8.0,
  });

  static DifficultyParams get(int difficulty) {
    switch (difficulty) {
      case 1:
        return DifficultyParams(
          ballMaxVelocity: viewWidth / 2,
          ballStartingVelocity: viewWidth / 2,
          disableCameraTilt: true,
          ballNudgeVelocity: 300,
          noiseScale: 0.8,
          g: 1000,
          badWallInvisibleProbability: 0.9,
          maxWallHeight: viewHeight / 2,
          minWallHeight: 0,
          badWallPenalty: 10,
          outOfTopBoundsPenalty: 10,
          maxWallWidth: 21.0,
          minWallWidth: 18.0,
        );
      case 2:
        return DifficultyParams(
          ballMaxVelocity: viewWidth,
          ballStartingVelocity: viewWidth / 2 * 1.5,
          disableCameraTilt: true,
          ballNudgeVelocity: 300,
          noiseScale: 0.7,
          g: 1500,
          badWallInvisibleProbability: 0.7,
          maxWallHeight: viewHeight,
          minWallHeight: 0,
          badWallPenalty: 10,
          outOfTopBoundsPenalty: 10,
          maxWallWidth: 21.0,
          minWallWidth: 18.0,
        );
      case 3:
        return DifficultyParams(
          ballMaxVelocity: viewWidth,
          ballStartingVelocity: viewWidth / 2 * 1.5,
          disableCameraTilt: true,
          ballNudgeVelocity: 250,
          noiseScale: 0.35,
          g: 1500,
          badWallInvisibleProbability: 0.5,
          maxWallHeight: viewHeight * 1.1,
          minWallHeight: 0,
          badWallPenalty: 10,
          outOfTopBoundsPenalty: 10,
          maxWallWidth: 21.0,
          minWallWidth: 18.0,
        );
      case 4:
        return DifficultyParams(
          ballMaxVelocity: viewWidth / 2,
          ballStartingVelocity: viewWidth / 2,
          disableCameraTilt: true,
          ballNudgeVelocity: 400,
          noiseScale: 0.1,
          g: 2500,
          badWallInvisibleProbability: 0.3,
          maxWallHeight: viewHeight * 0.9,
          minWallHeight: 0,
          badWallPenalty: 10,
          outOfTopBoundsPenalty: 10,
          maxWallWidth: 100.0,
          minWallWidth: 100.0,
        );
      case rlTrainDifficulty:
        return DifficultyParams(
          ballMaxVelocity: viewWidth / 2,
          ballStartingVelocity: viewWidth / 2,
          disableCameraTilt: true,
          ballNudgeVelocity: 400,
          noiseScale: 0.1,
          g: 2500,
          badWallInvisibleProbability: 0.3,
          maxWallHeight: viewHeight * 0.9,
          minWallHeight: 0,
          badWallPenalty: 2,
          outOfTopBoundsPenalty: 10,
          maxWallWidth: 100.0, // Keep min and max the same, easier to train.
          minWallWidth: 100.0,

          // ballMaxVelocity: viewWidth / 2,
          // ballStartingVelocity: viewWidth / 2,
          // disableCameraTilt: true,
          // ballNudgeVelocity: 300,
          // noiseScale: 0.8,
          // g: 1000,
          // badWallInvisibleProbability: 0.9,
          // maxWallHeight: viewHeight * 0.3,
          // minWallHeight: 0,
          // badWallPenalty: 100,
          // outOfTopBoundsPenalty: 100,
          // maxWallWidth: 21.0,
          // minWallWidth: 18.0,

          // ballMaxVelocity: viewWidth,
          // ballStartingVelocity: viewWidth / 2 * 1.5,
          // disableCameraTilt: true,
          // ballNudgeVelocity: 250,
          // noiseScale: 0.35,
          // g: 1500,
          // badWallInvisibleProbability: 0.5,
          // maxWallHeight: viewHeight * 1.1,
          // minWallHeight: 0,
          // badWallPenalty: 10,
          // outOfTopBoundsPenalty: 10,
          // maxWallWidth: 21.0,
          // minWallWidth: 18.0,
          maxTravelDistance: viewWidth * 10,
        );
      default:
        return DifficultyParams(
          ballMaxVelocity: viewHeight / 3.0 * 4.0,
          ballStartingVelocity: viewHeight / 3.0 * 4.0,
          disableCameraTilt: true,
          ballNudgeVelocity: 200,
          noiseScale: 0.2,
          g: 700,
          badWallInvisibleProbability: 0.7,
          maxWallHeight: viewHeight * 1,
          minWallHeight: 0,
          badWallPenalty: 10,
          outOfTopBoundsPenalty: 10,
          maxWallWidth: 21.0,
          minWallWidth: 18.0,
          maxTravelDistance: viewWidth * 50,
        );
    }
  }
}
