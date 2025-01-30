import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/utils/constants.dart';
import 'package:rapid_rounds/config/utils/custom_icons.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';
import 'package:rapid_rounds/config/utils/shadows.dart';
import 'package:rapid_rounds/features/home/presentation/components/home_button.dart';

class RoomManageContainer extends StatelessWidget {
  const RoomManageContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        width: 350,
        height: 210,
        decoration: BoxDecoration(
          color: GColors.gray,
          borderRadius: BorderRadius.circular(Constants.outterRadius),
          boxShadow: Shadows.elevation(),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -15,
              bottom: -11,
              //todo cached image
              child: Image.asset(
                'assets/images/mon4.png',
                width: 200,
                height: 250,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  Text(
                    '• Play Now',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Barr',
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: HomeButton(
                      onPressed: () {},
                      icon: Custom.magic_wand,
                      text: 'Create Room',
                      backgroundColor: GColors.sunGlow,
                      textColor: GColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: HomeButton(
                      onPressed: () {},
                      icon: Custom.leave,
                      text: 'Join Room',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
