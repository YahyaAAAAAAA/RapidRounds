import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/utils/constants.dart';
import 'package:rapid_rounds/config/utils/custom_icons.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';
import 'package:rapid_rounds/config/utils/shadows.dart';
import 'package:rapid_rounds/features/home/presentation/components/home_button.dart';

class NameContainer extends StatelessWidget {
  const NameContainer({
    super.key,
    required this.nameController,
  });

  final TextEditingController nameController;

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
          borderRadius: BorderRadius.circular(Constants.outterRadius),
          boxShadow: Shadows.elevation(),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -23,
              bottom: -30,
              //todo cached image
              child: Image.asset(
                'assets/images/mon3.png',
                width: 200,
                height: 250,
                fit: BoxFit.contain,
              ),
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
                SizedBox(
                  width: 100,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Player-882',
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: HomeButton(
                onPressed: () {
                  // Handle button tap
                },
                icon: Custom.user_moustache,
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
