import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/utils/constants.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';

class HomeButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;
  final String? text;
  final Color? backgroundColor;
  final Color? textColor;
  final FontWeight? fontWeight;

  const HomeButton({
    super.key,
    required this.icon,
    this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? GColors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.innerRadius),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        elevation: 0,
        overlayColor: GColors.white.withValues(alpha: 0.1),
        shadowColor: GColors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text ?? '',
            style: TextStyle(
              fontSize: 18,
              color: textColor ?? GColors.white,
              fontWeight: fontWeight ?? FontWeight.normal,
            ),
          ),
          SizedBox(width: 10),
          Icon(
            icon,
            color: textColor ?? GColors.white,
          ),
        ],
      ),
    );
  }
}
