import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/utils/animated_color_icon.dart';
import 'package:rapid_rounds/config/utils/custom_icons.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';

class MainMenuAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MainMenuAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        centerTitle: true,
        backgroundColor: GColors.gray.withValues(alpha: 0.5),
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedColorIcon(
                icon: Custom.mon_5,
                colors: [
                  GColors.black,
                  Colors.grey.shade800,
                  Colors.grey.shade900,
                  GColors.black,
                ],
                rotationAngle: 1,
                rotationDuration: Duration(seconds: 3),
                colorDuration: Duration(seconds: 3),
                size: 40,
              ),
              SizedBox(width: 5),
              Text(
                'Rapid Rounds',
                style: TextStyle(
                  color: GColors.black,
                  fontFamily: 'Barr',
                  fontSize: 35,
                ),
              ),
            ],
          ),
        ),
        leading: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.menu_rounded,
            color: GColors.black,
            size: 25,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextButton(
              onPressed: () {},
              child: Icon(
                Icons.settings,
                color: GColors.black,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
