import 'package:flame/components.dart';

mixin FixedUpdateMixin on Component {
  double _accumulator = 0.0;
  final double _fixedStep = 1.0 / 60.0; // Targeting 60 updates per second

  // Method to be overridden in the component that uses this mixin
  void fixedUpdate(double dt);

  void accumulateDt(double dt) {
    _accumulator += dt;
    while (_accumulator >= _fixedStep) {
      fixedUpdate(_fixedStep);
      _accumulator -= _fixedStep;
    }
  }
}
