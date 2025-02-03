import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/enums/avatars.dart';
import 'package:rapid_rounds/config/utils/constants.dart';
import 'package:rapid_rounds/config/utils/custom_icons.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';
import 'package:rapid_rounds/features/home/domain/models/widget_position.dart';
import 'package:rapid_rounds/features/home/presentation/components/home_button.dart';

class NameContainer extends StatelessWidget {
  final WidgetPosition widgetPosition;
  final TextEditingController nameController;
  final int avatarIndex;
  final VoidCallback? onNext;
  final VoidCallback? onBack;

  const NameContainer({
    super.key,
    required this.nameController,
    required this.widgetPosition,
    required this.avatarIndex,
    this.onNext,
    this.onBack,
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
          borderRadius: BorderRadius.circular(Constants.outterRadius),
          // boxShadow: Shadows.elevation(),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -23,
              bottom: -30,
              child: CachedNetworkImage(
                imageUrl: 'https://i.ibb.co/mWJHQ0X/mon3.png',
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
              top: null,
              child: HomeButton(
                onPressed: () async {
                  final selectedAvatarIndex = await showDialog<int>(
                    context: context,
                    builder: (context) {
                      int currentAvatarIndex =
                          avatarIndex; // Local state inside the dialog

                      return StatefulBuilder(
                        builder: (context, setState) => AlertDialog(
                          content: SizedBox(
                            width: 250,
                            height: 250,
                            child: Column(
                              children: [
                                Text(
                                  '${currentAvatarIndex + 1}/50',
                                  style: TextStyle(
                                    color: GColors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.arrow_back,
                                          color: GColors.black),
                                      onPressed: () {
                                        setState(() {
                                          currentAvatarIndex =
                                              (currentAvatarIndex -
                                                      1 +
                                                      AvatarIcon
                                                          .values.length) %
                                                  AvatarIcon.values.length;
                                        });
                                        if (onBack != null) onBack!();
                                      },
                                    ),
                                    Icon(
                                      AvatarIcon
                                          .values[currentAvatarIndex].icon,
                                      color: GColors.black,
                                      size: 25,
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.arrow_forward,
                                          color: GColors.black),
                                      onPressed: () {
                                        setState(() {
                                          currentAvatarIndex =
                                              (currentAvatarIndex + 1) %
                                                  AvatarIcon.values.length;
                                        });
                                        if (onNext != null) onNext!();
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context,
                                  currentAvatarIndex), // Return the selected index
                              child: Text('Save'),
                            ),
                          ],
                        ),
                      );
                    },
                  );

                  // Update the parent's state with the selected avatar index
                  if (selectedAvatarIndex != null) {
                    onNext?.call();
                    onBack?.call();
                  }
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
