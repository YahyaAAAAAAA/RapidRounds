import 'package:flutter/material.dart';
import 'package:neopop/neopop.dart';
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
    return NeoPopButton(
      onTapUp: onPressed,
      color: backgroundColor ?? GColors.black,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
      ),
    );
  }
}
