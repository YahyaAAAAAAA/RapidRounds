import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/enums/avatars.dart';
import 'package:rapid_rounds/config/extensions/build_context_extension.dart';
import 'package:rapid_rounds/config/utils/constants.dart';
import 'package:rapid_rounds/config/utils/custom_icons.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';
import 'package:rapid_rounds/config/utils/pop_button.dart';

class AvatarSelectorDialog extends StatelessWidget {
  final int avatarIndex;
  final void Function()? onNext;
  final void Function()? onRandom;

  const AvatarSelectorDialog({
    super.key,
    required this.avatarIndex,
    this.onNext,
    this.onRandom,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          backgroundColor: GColors.springWood,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kOutterRadius),
          ),
          content: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '• Choose Avatar',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Barr',
                    ),
                  ),
                  PopButton.icon(
                    onTap: () => context.pop(),
                    icon: Icons.clear,
                    iconSize: 15,
                    padding: EdgeInsets.all(2),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${avatarIndex + 1}/50',
                    style: TextStyle(
                      color: GColors.black,
                      fontSize: 20,
                      fontFamily: 'Barr',
                    ),
                  ),
                  SizedBox(width: 60),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PopButton.child(
                    backgroundColor: GColors.gray,
                    padding: EdgeInsets.all(14),
                    //todo not sure?
                    onTap: () => context.pop(),
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        // Slide transition for the outgoing widget (to the right)
                        if (child.key == ValueKey<int>(avatarIndex)) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset(1.0, 0.3), // Start from the center
                              end: Offset.zero, // Slide to the right
                            ).animate(animation),
                            child: FadeTransition(
                                opacity: Tween<double>(begin: 0, end: 1)
                                    .animate(animation),
                                child: child),
                          );
                        } else {
                          // Slide transition for the incoming widget (from the left)
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset(-1.5, 0.1), // Start from the left
                              end: Offset.zero, // Slide to the center
                            ).animate(animation),
                            child: FadeTransition(
                                opacity: Tween<double>(begin: 0, end: 1)
                                    .animate(animation),
                                child: child),
                          );
                        }
                      },
                      child: Icon(
                        AvatarIcon.values[avatarIndex].icon,
                        color: GColors.black,
                        key: ValueKey<int>(avatarIndex),
                        size: 50,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    children: [
                      PopButton.icon(
                        icon: Custom.arrow_small_right,
                        onTap: onNext,
                      ),
                      PopButton.icon(
                        //todo change (more thick)
                        icon: Custom.shuffle,
                        onTap: onRandom,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
