import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';

class GLoading extends StatelessWidget {
  final Color? color;
  final double? value;

  const GLoading({
    super.key,
    this.color,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: CircularProgressIndicator(
        value: value,
        color: color ?? GColors.black.withValues(alpha: 0.5),
      ),
    );
  }
}
