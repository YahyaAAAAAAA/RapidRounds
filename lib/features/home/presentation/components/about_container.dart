import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';
import 'package:rapid_rounds/config/utils/shadows.dart';
import 'package:rapid_rounds/features/home/presentation/components/home_button.dart';

class AboutContainer extends StatelessWidget {
  const AboutContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        width: 400,
        height: 130,
        decoration: BoxDecoration(
          color: GColors.gray,
          borderRadius: BorderRadius.circular(12),
          boxShadow: Shadows.elevation(),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: -25,
              left: -5,
              //todo cached image
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..scale(-1.0, 1.0), // Flip horizontally
                child: Image.asset(
                  'assets/images/mon2.png',
                  width: 200,
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                '• How To Play',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Barr'),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 20,
                  children: [
                    SizedBox(
                      width: 150,
                      child: HomeButton(
                        onPressed: () {},
                        icon: Icons.info_outline_rounded,
                        text: 'About',
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: HomeButton(
                        onPressed: () {},
                        icon: Icons.person,
                        text: 'Contact',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
