import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopop/widgets/buttons/neopop_tilted_button/neopop_tilted_button.dart';
import 'package:rapid_rounds/config/extensions/build_context_extension.dart';
import 'package:rapid_rounds/config/utils/app_scaffold.dart';
import 'package:rapid_rounds/config/utils/background_image.dart';
import 'package:rapid_rounds/config/utils/constants.dart';
import 'package:rapid_rounds/config/utils/custom_icons.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';
import 'package:rapid_rounds/config/utils/global_loading.dart';
import 'package:rapid_rounds/features/home/presentation/components/main_menu_sub_appbar.dart';
import 'package:rapid_rounds/features/room/presentation/cubits/room_cubit.dart';
import 'package:rapid_rounds/features/room/presentation/cubits/room_state.dart';
import 'room_page.dart';

class JoinRoomPage extends StatefulWidget {
  final String playerName;
  final int playerAvatar;

  const JoinRoomPage({
    super.key,
    required this.playerName,
    required this.playerAvatar,
  });

  @override
  State<JoinRoomPage> createState() => _JoinRoomPageState();
}

class _JoinRoomPageState extends State<JoinRoomPage> {
  late final RoomCubit roomCubit;
  final TextEditingController roomCodeController = TextEditingController();
  String? errorText;

  @override
  void initState() {
    super.initState();

    roomCubit = context.read<RoomCubit>();
  }

  @override
  void dispose() {
    roomCodeController.dispose();
    super.dispose();
  }

  void navigateToRoom(String roomId) =>
      context.replace(RoomPage(roomId: roomId));

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: MainMenuSubAppbar(
        text: 'Join Room',
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: kListViewWidth,
            ),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(8),
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 15,
                    ),
                    width: 300,
                    height: 400,
                    decoration: BoxDecoration(
                      color: GColors.gray,
                      borderRadius: BorderRadius.circular(kOutterRadius),
                    ),
                    child: Stack(
                      children: [
                        BackgroundImage(
                          imageUrl: 'https://i.ibb.co/v4K52ZTk/mon7.png',
                          top: 30,
                          right: 30,
                          width: 250,
                          height: 400,
                        ),
                        BackgroundImage(
                          top: 15,
                          right: -10,
                          imageUrl: 'https://i.ibb.co/wFMcr59t/mon8.png',
                          width: 100,
                          height: 100,
                        ),
                        BlocBuilder<RoomCubit, RoomStates>(
                            builder: (context, state) {
                          //loading (when done will navigate out)
                          return Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: NeoPopTiltedButton(
                                isFloating: true,
                                onTapUp: () async {
                                  final roomId = roomCodeController.text.trim();

                                  if (roomId.isEmpty) {
                                    setState(() => errorText = 'Enter Code');
                                    return;
                                  }

                                  final success = await roomCubit.joinRoom(
                                    roomId: roomId,
                                    playerName: widget.playerName,
                                    playerAvatar: widget.playerAvatar,
                                  );

                                  if (!mounted) return;

                                  if (success) {
                                    navigateToRoom(roomId);
                                  } else {
                                    setState(() => errorText = 'Invalid Code');
                                  }
                                },
                                decoration: NeoPopTiltedButtonDecoration(
                                  color: GColors.sunGlow,
                                  showShimmer: true,
                                  shadowColor:
                                      GColors.black.withValues(alpha: 0.5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 80.0,
                                    vertical: 15,
                                  ),
                                  child: AnimatedContainer(
                                    width: state is RoomLoading ? 60 : 120,
                                    duration: Duration(milliseconds: 300),
                                    child: state is RoomLoading
                                        ? FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: GLoading(
                                              color: GColors.black,
                                            ),
                                          )
                                        : FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Join Room',
                                                  style: TextStyle(
                                                    color: GColors.black,
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Icon(
                                                  Custom.arrow_small_right,
                                                  color: GColors.black,
                                                )
                                              ],
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '• Enter Code',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'Barr',
                              ),
                            ),
                            SizedBox(width: 20),
                            SizedBox(
                              width: 80,
                              height: 50,
                              child: TextField(
                                controller: roomCodeController,
                                style: TextStyle(
                                  color: GColors.black,
                                ),
                                onChanged: (value) {
                                  if (errorText != null) {
                                    setState(() => errorText = null);
                                  }
                                },
                                decoration: InputDecoration(
                                  errorText: errorText,
                                  hintText: 'CODEHERE',
                                  focusColor: GColors.white,
                                  fillColor: GColors.white,
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
