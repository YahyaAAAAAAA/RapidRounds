import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/enums/avatars.dart';
import 'package:rapid_rounds/config/extensions/build_context_extension.dart';
import 'package:rapid_rounds/config/utils/app_scaffold.dart';
import 'package:rapid_rounds/config/utils/constants.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';
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
  int avatarIndex = 0;

  @override
  void initState() {
    super.initState();

    nameController.text = 'Player-${Random().nextInt(900) + 100}';
    buttonsPosition.right = 110;
    buttonsPosition.width = 250;

    Future.delayed(
      Duration(milliseconds: 500),
      () {
        setState(() {
          buttonsPosition.right = 0;
          buttonsPosition.width = 150;
        });
      },
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void _updateAvatarIndex(int newIndex) {
    setState(() {
      avatarIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: MainMenuAppbar(),
      points: GColors.scaffoldMesh,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: Constants.listViewWidth,
            ),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(8),
              children: [
                NameContainer(
                  nameController: nameController,
                  widgetPosition: buttonsPosition,
                  avatarIndex: avatarIndex,
                  onNext: () => _updateAvatarIndex(
                      (avatarIndex + 1) % AvatarIcon.values.length),
                  onBack: () => _updateAvatarIndex(
                      (avatarIndex - 1 + AvatarIcon.values.length) %
                          AvatarIcon.values.length),
                ),
                SizedBox(height: 20),
                RoomManageContainer(
                  widgetPosition: buttonsPosition,
                  onCreateRoomPressed: () => context.push(
                    CreateRoomPage(playerName: nameController.text),
                  ),
                  onJoinRoomPressed: () => context.push(
                    JoinRoomPage(playerName: nameController.text),
                  ),
                ),
                //? maybe
                // AboutContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
