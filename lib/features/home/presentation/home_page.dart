import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/utils/animated_color_icon.dart';
import 'package:rapid_rounds/config/utils/animated_color_text.dart';
import 'package:rapid_rounds/config/utils/app_scaffold.dart';
import 'package:rapid_rounds/config/utils/constants.dart';
import 'package:rapid_rounds/config/utils/custom_icons.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';
import 'package:rapid_rounds/features/home/presentation/components/room_manage_container.dart';
import 'package:rapid_rounds/features/home/presentation/components/name_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: GColors.gray.withValues(alpha: 0.5),
        title: Text(
          'Main Menu',
          style: TextStyle(
            color: GColors.black,
            fontSize: 30,
          ),
        ),
        leading: TextButton(
          onPressed: () {},
          child: Icon(
            Icons.menu_outlined,
            color: GColors.black,
            size: 25,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextButton(
              onPressed: () {},
              child: Icon(
                Icons.settings,
                color: GColors.black,
                size: 25,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: Constants.listViewWidth,
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedColorText(
                        text: 'Rapid Rounds',
                        colors: [
                          Colors.black,
                          const Color.fromARGB(255, 158, 158, 158),
                          const Color.fromARGB(255, 49, 49, 49),
                        ],
                        style: TextStyle(
                          fontFamily: 'Barr',
                          fontSize: 60,
                          color: GColors.black,
                        ),
                      ),
                      AnimatedColorIcon(
                        colors: [
                          GColors.sunGlow,
                          Colors.orange,
                        ],
                        colorDuration: Duration(seconds: 3),
                        rotationDuration: Duration(seconds: 2),
                        rotationAngle: 3,
                        icon: Custom.mon_5,
                        size: 80,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),
              NameContainer(nameController: nameController),
              SizedBox(height: 20),
              RoomManageContainer(),
              SizedBox(height: 20),
              //? maybe
              // AboutContainer(),
              // HomeButton(
              //   icon: Icons.create_rounded,
              //   text: 'Create Room',
              //   backgroundColor: GColors.sunGlow,
              //   textColor: GColors.black,
              //   fontWeight: FontWeight.bold,
              //   onPressed: () {
              //     if (nameController.text.trim().isEmpty) {
              //       //todo add snack bar or validate ?
              //       return;
              //     }

              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (_) => CreateRoomPage(
              //           playerName: nameController.text,
              //         ),
              //       ),
              //     );
              //   },
              // ),
              // SizedBox(height: 20),
              // HomeButton(
              //   icon: Icons.meeting_room_outlined,
              //   text: 'join Room    ',
              //   onPressed: () {
              //     if (nameController.text.trim().isEmpty) {
              //       //todo add snack bar or validate ?
              //       return;
              //     }

              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (_) => JoinRoomPage(
              //           playerName: nameController.text,
              //         ),
              //       ),
              //     );
              //   },
              // ),
              // SizedBox(height: 20),
              // HomeButton(
              //   icon: Icons.info_outline_rounded,
              //   text: 'Test Room   ',
              //   onPressed: () => Navigator.of(context).pop(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
