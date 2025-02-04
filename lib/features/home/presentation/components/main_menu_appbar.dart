import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/extensions/build_context_extension.dart';
import 'package:rapid_rounds/config/utils/animated_color_icon.dart';
import 'package:rapid_rounds/config/utils/custom_icons.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';
import 'package:rapid_rounds/config/utils/pop_button.dart';

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
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PopButton.icon(
            onTap: () => context.pop(),
            icon: Custom.bars_staggered,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: PopButton.icon(
              onTap: () {},
              icon: Custom.settings,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
