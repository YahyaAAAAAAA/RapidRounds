import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/utils/background_image.dart';
import 'package:rapid_rounds/config/utils/constants.dart';
import 'package:rapid_rounds/config/utils/custom_icons.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';
import 'package:rapid_rounds/config/utils/pop_button.dart';
import 'package:rapid_rounds/features/home/domain/models/widget_position.dart';

class RoomManageContainer extends StatelessWidget {
  final void Function()? onCreateRoomPressed;
  final void Function()? onJoinRoomPressed;
  final WidgetPosition widgetPosition;

  const RoomManageContainer({
    super.key,
    required this.widgetPosition,
    this.onCreateRoomPressed,
    this.onJoinRoomPressed,
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
          borderRadius: BorderRadius.circular(kOutterRadius),
        ),
        child: Stack(
          children: [
            BackgroundImage(
              right: -15,
              bottom: -11,
              imageUrl: 'https://i.ibb.co/kVjMX49K/mon4.png',
              width: 200,
              height: 250,
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
                ],
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              width: widgetPosition.width,
              curve: Curves.easeInOut,
              left: 12,
              bottom: 100,
              child: PopButton(
                onTap: onCreateRoomPressed,
                text: 'Create Room',
                icon: Custom.magic_wand,
                backgroundColor: GColors.sunGlow,
                textColor: GColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: widgetPosition.width,
              left: 12,
              bottom: 40,
              child: PopButton(
                onTap: onJoinRoomPressed,
                icon: Custom.leave,
                text: 'Join Room',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
