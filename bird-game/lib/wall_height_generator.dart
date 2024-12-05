import 'dart:math';

import 'package:fast_noise/fast_noise.dart';
import 'package:flame/game.dart';
import 'package:lame_hexagon/config.dart';

abstract class WallHeightGenerator {
  // Allow generating multiple walls at once for positions startX to endX
  // inclusive Returns a list of wall position and size attributes of the form
  // (tl_x, tl_y, width, height) and a double representing the end x position to
  // be used for the next invocation.
  (List<Vector4>, double) generateWallHeights(double startX, double? endX);
}

const double _defaultNoiseOffset = 0.2;

class PerlinWallHeightGenerator implements WallHeightGenerator {
  final Random _rng;
  final double _noiseOffset;
  final DifficultyParams diffParams;

  late Noise2 _noise;

  PerlinWallHeightGenerator(
    this._rng, {
    required int seed,
    double noiseOffset = _defaultNoiseOffset,
    required this.diffParams,
  }) : _noiseOffset = noiseOffset {
    _noise = PerlinNoise(seed: seed);
  }

  @override
  (List<Vector4>, double) generateWallHeights(double startX, double? endX) {
    var walls = <Vector4>[];

    var currentX = startX;

    while (currentX <= (endX ?? startX)) {
      double wallWidth = _generateWallWidth();
      double wallHeight = _generateWallHeight(currentX);

      walls.add(
          Vector4(currentX, diffParams.minWallHeight, wallWidth, wallHeight));

      // Use a constant gap between walls. Commented out the random.
      // // currentX += wallWidth + _rng.nextDouble() * 10; // Small gap between walls
      currentX += wallWidth + minWallGap;
    }

    return (walls, currentX);
  }

  double _generateWallWidth() {
    // Generate a random width between minWallWidth and maxWallWidth
    return _rng.nextDouble() *
            (diffParams.maxWallWidth - diffParams.minWallWidth) +
        diffParams.minWallWidth;
  }

  double _generateWallHeight(double x) {
    // Use noise function to generate height
    double noiseValue =
        _noise.getNoise2(x * diffParams.noiseScale + _noiseOffset, 0);

    // Map noise value (-1 to 1) to wall height range
    double height = ((noiseValue + 1) / 2) *
            (diffParams.maxWallHeight - diffParams.minWallHeight) +
        diffParams.minWallHeight;

    // Add some randomness to the height
    height += (_rng.nextDouble() - 0.5) * 20;

    return height.clamp(diffParams.minWallHeight, diffParams.maxWallHeight);
  }
}
