import 'dart:math';

import 'package:fast_noise/fast_noise.dart';
import 'package:lame_hexagon/components/wall.dart';
import 'package:lame_hexagon/config.dart';

const double _noiseScale = 0.7;
const double _noiseOffset = 0.2;

class PerlinWallGenerator {
  final Random _rng;

  late Noise2 _noise;

  PerlinWallGenerator(this._rng, {required int seed}) {
    _noise = PerlinNoise(seed: seed);
  }

  List<WallComponent> generateWalls(double startX, double endX) {
    var walls = <WallComponent>[];

    var currentX = startX;

    while (currentX < endX) {
      double wallWidth = _generateWallWidth();
      double wallHeight = _generateWallHeight(currentX);

      WallComponent wall = WallComponent()
        ..x = currentX
        ..y = minWallHeight
        ..width = wallWidth
        ..height = wallHeight;

      walls.add(wall);

      currentX += wallWidth +
          minWallGap +
          _rng.nextDouble() * maxWallGap; // Small gap between walls
    }

    return walls;
  }

  double _generateWallWidth() {
    // Generate a random width between minWallWidth and maxWallWidth
    return _rng.nextDouble() * (maxWallWidth - minWallWidth) + minWallWidth;
  }

  double _generateWallHeight(double x) {
    // Use noise function to generate height
    double noiseValue = _noise.getNoise2(x * _noiseScale + _noiseOffset, 0);

    // Map noise value (-1 to 1) to wall height range
    double height = ((noiseValue + 1) / 2) * (maxWallHeight - minWallHeight) +
        minWallHeight;

    // Add some randomness to the height
    height += (_rng.nextDouble() - 0.5) * 20;

    return height.clamp(minWallHeight, maxWallHeight);
  }
}
