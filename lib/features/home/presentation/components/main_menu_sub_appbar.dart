import 'package:flutter/material.dart';
import 'package:neopop/neopop.dart';
import 'package:rapid_rounds/config/extensions/build_context_extension.dart';
import 'package:rapid_rounds/config/utils/custom_icons.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';

class MainMenuSubAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  const MainMenuSubAppbar({
    super.key,
    required this.text,
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
          child: NeoPopButton(
            onTapUp: () => context.pop(),
            color: GColors.gray,
            child: Icon(
              Custom.arrow_small_left,
              color: GColors.black,
              size: 25,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: NeoPopButton(
              onTapUp: () {},
              color: GColors.gray,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.report_problem_outlined,
                  color: GColors.black,
                  size: 25,
                ),
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
