import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/utils/constants.dart';
import 'package:rapid_rounds/config/utils/custom_icons.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';
import 'package:rapid_rounds/features/home/domain/models/widget_position.dart';
import 'package:rapid_rounds/features/home/presentation/components/home_button.dart';

class RoomManageContainer extends StatelessWidget {
  final void Function()? onCreateRoomPressed;
  final void Function()? onJoinRoomPressed;
  final WidgetPosition widgetPosition;
  final double imageOpacity;

  const RoomManageContainer({
    super.key,
    required this.widgetPosition,
    required this.imageOpacity,
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
          borderRadius: BorderRadius.circular(Constants.outterRadius),
          // boxShadow: Shadows.elevation(),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -15,
              bottom: -11,
              //todo cached image
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: imageOpacity,
                child: Image.asset(
                  'assets/images/mon4.png',
                  width: 200,
                  height: 250,
                  fit: BoxFit.contain,
                ),
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
                ],
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              width: widgetPosition.width,
              curve: Curves.easeInOut,
              left: 12,
              bottom: 100,
              child: HomeButton(
                onPressed: onCreateRoomPressed,
                icon: Custom.magic_wand,
                text: 'Create Room',
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
              child: HomeButton(
                onPressed: onJoinRoomPressed,
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
