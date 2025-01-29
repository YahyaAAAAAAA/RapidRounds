import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/global_colors.dart';

class HomeButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final FontWeight? fontWeight;

  const HomeButton({
    super.key,
    required this.icon,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor:
              WidgetStatePropertyAll(backgroundColor ?? GColors.black),
          elevation: WidgetStatePropertyAll(2),
          overlayColor: WidgetStatePropertyAll(
            GColors.white.withValues(alpha: 0.1),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        iconAlignment: IconAlignment.end,
        icon: Icon(
          icon,
          color: textColor ?? GColors.white,
          size: 25,
        ),
        label: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(
              color: textColor ?? GColors.white,
              fontSize: 25,
              fontWeight: fontWeight ?? FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
