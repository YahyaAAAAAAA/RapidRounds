import 'dart:ui';

import 'package:flutter/material.dart';

class GlowingBackground extends StatelessWidget {
  const GlowingBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 255, 255, 255), // Lavender
                  Color.fromARGB(255, 215, 215, 215), // Light Blue
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Glowing circular shapes
          Positioned.fill(
            child: Stack(
              children: [
                Positioned(
                  top: 100,
                  left: 50,
                  child: _buildCircle(200, Colors.pink.withValues(alpha: 0.4)),
                ),
                Positioned(
                  bottom: 150,
                  right: 50,
                  child: _buildCircle(250, Colors.blue.withValues(alpha: 0.3)),
                ),
                Positioned(
                  top: 200,
                  right: 100,
                  child:
                      _buildCircle(220, Colors.purple.withValues(alpha: 0.35)),
                ),
              ],
            ),
          ),
          // Blur effect
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create glowing circles
  Widget _buildCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color,
            color.withValues(alpha: 0.1),
          ],
          stops: [0.3, 1.0],
        ),
      ),
    );
  }
}
