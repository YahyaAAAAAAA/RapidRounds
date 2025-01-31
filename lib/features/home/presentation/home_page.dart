import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/utils/app_scaffold.dart';
import 'package:rapid_rounds/config/utils/constants.dart';
import 'package:rapid_rounds/features/home/domain/models/widget_position.dart';
import 'package:rapid_rounds/features/home/presentation/components/main_menu_appbar.dart';
import 'package:rapid_rounds/features/home/presentation/components/room_manage_container.dart';
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
  WidgetPosition buttonsPosition = WidgetPosition();
  WidgetPosition roomButtonPosition = WidgetPosition();
  double imageOpacity = 0;

  @override
  void initState() {
    super.initState();

    nameController.text = 'Player-${Random().nextInt(900) + 100}';
    buttonsPosition.right = 110;
    buttonsPosition.width = 250;
    imageOpacity = 0;

    Future.delayed(
      Duration(milliseconds: 100),
      () {
        setState(() {
          buttonsPosition.right = 0;
          buttonsPosition.width = 150;
          imageOpacity = 1;
        });
      },
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: MainMenuAppbar(),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: Constants.listViewWidth,
          ),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 8),
            children: [
              NameContainer(
                nameController: nameController,
                widgetPosition: buttonsPosition,
                imageOpacity: imageOpacity,
              ),
              SizedBox(height: 20),
              RoomManageContainer(
                widgetPosition: buttonsPosition,
                imageOpacity: imageOpacity,
                onCreateRoomPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreateRoomPage(
                      playerName: nameController.text,
                    ),
                  ),
                ),
                onJoinRoomPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => JoinRoomPage(
                      playerName: nameController.text,
                    ),
                  ),
                ),
              ),
              //? maybe
              // AboutContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
