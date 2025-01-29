import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/app_scaffold.dart';
import 'package:rapid_rounds/config/constants.dart';
import 'package:rapid_rounds/config/global_colors.dart';
import 'package:rapid_rounds/features/home/presentation/components/home_button.dart';
import 'package:rapid_rounds/features/home/presentation/components/name_container.dart';
import 'package:rapid_rounds/features/room/presentation/pages/create_room_page.dart';
import 'package:rapid_rounds/features/room/presentation/pages/join_room_page.dart';

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
                      Text(
                        'Rapid Rounds',
                        style: TextStyle(
                          fontFamily: 'Barr',
                          fontSize: 60,
                          color: GColors.black,
                        ),
                      ),
                      Icon(
                        Icons.bolt_rounded,
                        color: GColors.sunGlow,
                        size: 80,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              NameContainer(nameController: nameController),
              SizedBox(height: 20),
              HomeButton(
                icon: Icons.create_rounded,
                text: 'Create Room',
                backgroundColor: GColors.sunGlow,
                textColor: GColors.black,
                fontWeight: FontWeight.bold,
                onPressed: () {
                  if (nameController.text.trim().isEmpty) {
                    //todo add snack bar or validate ?
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CreateRoomPage(
                        playerName: nameController.text,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              HomeButton(
                icon: Icons.meeting_room_outlined,
                text: 'join Room    ',
                onPressed: () {
                  if (nameController.text.trim().isEmpty) {
                    //todo add snack bar or validate ?
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => JoinRoomPage(
                        playerName: nameController.text,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              HomeButton(
                icon: Icons.info_outline_rounded,
                text: 'Test Room   ',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
