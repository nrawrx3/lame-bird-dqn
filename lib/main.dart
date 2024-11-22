import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:lame_hexagon/app_selector.dart';

void main() {
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  runApp(const MyApp());
}
