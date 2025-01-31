import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class GColors {
  static Color springWood = Color(0xFFf5f4ed);
  static Color sunGlow = Color(0xFFffc62f);
  static Color black = const Color(0xFF1A1110);
  static Color white = Colors.white;
  static Color gray = Color(0xFFeae7da);
  static Color transparent = Colors.transparent;

  static Color scaffoldBg = springWood;
  static Color appBarBg = Colors.transparent;

  static LinearGradient logoGradient = LinearGradient(
    colors: [
      sunGlow,
      sunGlow,
    ],
  );

  static List<MeshGradientPoint> scaffoldMesh = [
    MeshGradientPoint(
      position: const Offset(
        0,
        0,
      ),
      color: const Color(0xFFf5f4ed),
    ),
    MeshGradientPoint(
      position: const Offset(
        1,
        0,
      ),
      color: const Color(0xFFDEDDD3),
    ),
    MeshGradientPoint(
      position: const Offset(
        1,
        1,
      ),
      color: const Color(0xFFf5f4ed),
    ),
    MeshGradientPoint(
      position: const Offset(
        0,
        1,
      ),
      color: const Color.fromARGB(255, 222, 221, 211),
    ),
  ];
}
