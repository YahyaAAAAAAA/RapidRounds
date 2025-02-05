import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/enums/avatars.dart';
import 'package:rapid_rounds/config/utils/background_image.dart';
import 'package:rapid_rounds/config/utils/constants.dart';
import 'package:rapid_rounds/config/utils/custom_icons.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';
import 'package:rapid_rounds/config/utils/pop_button.dart';
import 'package:rapid_rounds/features/home/domain/models/widget_position.dart';

class NameContainer extends StatelessWidget {
  final WidgetPosition widgetPosition;
  final TextEditingController nameController;
  final int avatarIndex;
  final void Function()? onPressed;

  const NameContainer({
    super.key,
    required this.nameController,
    required this.widgetPosition,
    required this.avatarIndex,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 20,
        ),
        width: 300,
        height: 250,
        decoration: BoxDecoration(
          color: GColors.gray,
          borderRadius: BorderRadius.circular(kOutterRadius),
        ),
        child: Stack(
          children: [
            BackgroundImage(
              bottom: -30,
              right: -23,
              width: 200,
              height: 250,
              imageUrl: 'https://i.ibb.co/mWJHQ0X/mon3.png',
            ),
            // Text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• Enter Name',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Barr',
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: SizedBox(
                    width: 120,
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'Your Name',
                        icon: Icon(
                          AvatarIcon.values[avatarIndex].icon,
                          color: GColors.black,
                          size: 30,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              bottom: 16,
              left: 0,
              right: widgetPosition.right,
              child: PopButton(
                onTapUp: onPressed,
                icon: Custom.user_astronaut,
                backgroundColor: GColors.black,
                text: 'Choose Avatar',
              ),
            )
          ],
        ),
      ),
    );
  }
}
