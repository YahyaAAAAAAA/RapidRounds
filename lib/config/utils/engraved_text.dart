import 'package:flutter/material.dart';

class NeumorphicText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;

  const NeumorphicText({
    super.key,
    required this.text,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Light shadow
        Text(
          text,
          style: textStyle.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.fill
              ..color = Colors.white,
            shadows: [
              Shadow(
                color: Colors.white.withValues(alpha: 0.8),
                offset: const Offset(-2, -2),
                blurRadius: 4,
              ),
            ],
          ),
        ),
        // Dark shadow
        Text(
          text,
          style: textStyle.copyWith(
            shadows: [
              Shadow(
                color: Colors.grey.shade500,
                offset: const Offset(2, 2),
                blurRadius: 4,
              ),
            ],
          ),
        ),
        // Main text
        Text(
          text,
          style: textStyle,
        ),
      ],
    );
  }
}
