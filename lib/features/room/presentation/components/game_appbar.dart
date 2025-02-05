import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/extensions/build_context_extension.dart';
import 'package:rapid_rounds/config/utils/animated_counter_text.dart';
import 'package:rapid_rounds/config/utils/custom_icons.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';
import 'package:rapid_rounds/config/utils/pop_button.dart';

class GameAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final PreferredSize? bottom;
  final int solveTime;

  const GameAppbar({
    super.key,
    required this.text,
    required this.solveTime,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        centerTitle: true,
        bottom: bottom,
        backgroundColor: GColors.gray.withValues(alpha: 0.5),
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Custom.mon_5,
                color: GColors.black,
                size: 40,
              ),
              SizedBox(width: 5),
              Text(
                text,
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
            onTapUp: () => context.pop(),
            icon: Custom.arrow_small_left,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                PopButton.icon(
                  icon: Custom.duration_alt,
                ),
                PopButton.child(
                  backgroundColor: GColors.gray,
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: AnimatedCounterText(
                    counter: solveTime,
                    oldCounter: solveTime,
                    style: TextStyle(
                      color: GColors.black,
                      fontSize: 30,
                      fontFamily: 'Barr',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
