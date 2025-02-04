import 'package:flutter/material.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';

enum PopButtonType {
  icon,
  text,
  child,
  none,
}

class PopButton extends StatelessWidget {
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final void Function()? onTap;

  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;

  const PopButton({
    super.key,
    required this.text,
    this.textColor = GColors.white,
    this.textSize = 18,
    this.fontWeight = FontWeight.normal,
    this.fontFamily = 'Abel',
    required this.icon,
    this.iconColor = GColors.white,
    this.iconSize = 24,
    this.backgroundColor = GColors.black,
    this.padding = const EdgeInsets.all(12),
    this.onTap,
  })  : child = null,
        isSelectable = null;

  const PopButton.icon({
    super.key,
    this.icon,
    this.iconColor = GColors.black,
    this.iconSize = 24,
    this.backgroundColor = GColors.gray,
    this.padding = const EdgeInsets.all(8),
    this.onTap,
  })  : text = null,
        textColor = null,
        textSize = null,
        fontWeight = null,
        fontFamily = null,
        child = null,
        isSelectable = null;

  final String? text;
  final double? textSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final bool? isSelectable;

  const PopButton.text({
    super.key,
    required this.text,
    this.textSize = 17,
    this.textColor = GColors.black,
    this.fontWeight = FontWeight.normal,
    this.fontFamily = 'Abel',
    this.isSelectable = false,
    this.backgroundColor = GColors.gray,
    this.padding = const EdgeInsets.all(8),
    this.onTap,
  })  : icon = null,
        iconColor = null,
        iconSize = null,
        child = null;

  final Widget? child;

  const PopButton.child({
    super.key,
    required this.child,
    this.backgroundColor = GColors.black,
    this.padding = const EdgeInsets.all(12),
    this.onTap,
  })  : text = null,
        textSize = null,
        textColor = null,
        fontWeight = null,
        fontFamily = null,
        icon = null,
        iconColor = null,
        iconSize = null,
        isSelectable = null;

  PopButtonType decide() {
    if (child != null) {
      return PopButtonType.child;
    } else if (icon != null && text != null) {
      return PopButtonType.none;
    } else if (icon != null) {
      return PopButtonType.icon;
    } else {
      return PopButtonType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (decide() == PopButtonType.icon) {
      return NeoPopButton(
        onTapUp: onTap,
        color: backgroundColor!,
        disabledColor: backgroundColor!,
        child: Padding(
          padding: padding!,
          child: Icon(
            icon,
            color: iconColor!,
            size: iconSize!,
          ),
        ),
      );
    } else if (decide() == PopButtonType.text) {
      return NeoPopButton(
        onTapUp: onTap,
        color: backgroundColor!,
        disabledColor: backgroundColor!,
        child: Padding(
          padding: padding!,
          child: isSelectable!
              ? SelectableText(
                  text!,
                  style: TextStyle(
                    fontSize: textSize,
                    color: textColor,
                    fontWeight: fontWeight,
                    fontFamily: fontFamily,
                  ),
                )
              : Text(
                  text!,
                  style: TextStyle(
                    fontSize: textSize,
                    color: textColor,
                    fontWeight: fontWeight,
                    fontFamily: fontFamily,
                  ),
                ),
        ),
      );
    } else if (decide() == PopButtonType.child) {
      return NeoPopButton(
        onTapUp: onTap,
        color: backgroundColor!,
        disabledColor: backgroundColor!,
        child: Padding(
          padding: padding!,
          child: child,
        ),
      );
    } else {
      return NeoPopButton(
        onTapUp: onTap,
        color: backgroundColor!,
        child: Padding(
          padding: padding!,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text!,
                style: TextStyle(
                  color: textColor,
                  fontSize: textSize,
                  fontWeight: fontWeight,
                  fontFamily: fontFamily,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                icon,
                color: textColor,
                size: iconSize,
              ),
            ],
          ),
        ),
      );
    }
  }
}
