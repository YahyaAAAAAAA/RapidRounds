import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_rounds/config/utils/app_scaffold.dart';
import 'package:rapid_rounds/config/utils/constants.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';
import 'package:rapid_rounds/features/home/presentation/components/main_menu_sub_appbar.dart';
import 'package:rapid_rounds/features/room/presentation/components/create_room_counter_row.dart';
import 'package:rapid_rounds/features/room/presentation/cubits/room_cubit.dart';
import 'room_page.dart';

class CreateRoomPage extends StatefulWidget {
  final String playerName;

  const CreateRoomPage({
    super.key,
    required this.playerName,
  });

  @override
  State<CreateRoomPage> createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  late final RoomCubit roomCubit;

  @override
  void initState() {
    super.initState();

    //get cubit
    roomCubit = context.read<RoomCubit>();

    // createRoom();
  }

  Future<void> createRoom() async {
    //create room
    final roomId = await roomCubit.createRoom(widget.playerName);

    //ensure mounted
    if (!mounted) return;

    //navigate to room
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => RoomPage(roomId: roomId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: MainMenuSubAppbar(text: 'Create Room'),
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
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 12,
                      top: 15,
                    ),
                    width: 400,
                    height: 500,
                    decoration: BoxDecoration(
                      color: GColors.gray,
                      borderRadius:
                          BorderRadius.circular(Constants.outterRadius),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          // top: 15,
                          left: 30,
                          child: Image.asset(
                            'assets/images/mon9.png',
                            fit: BoxFit.contain,
                            width: 400,
                            height: 500,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 20,
                          children: [
                            Text(
                              '• Create Room',
                              style: TextStyle(
                                color: GColors.black,
                                fontSize: 20,
                                fontFamily: 'Barr',
                              ),
                            ),
                            CreateRoomCounterRow(
                              text: 'Rounds Number',
                              counter: 10,
                              onIncrement: () {},
                              onDecrement: () {},
                            ),
                            CreateRoomCounterRow(
                              text: 'Players Count',
                              counter: 15,
                              onIncrement: () {},
                              onDecrement: () {},
                            ),
                            SizedBox(
                              width: 250,
                              height: 50,
                              child: ScrollConfiguration(
                                behavior: MyCustomScrollBehavior(),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: 15,
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(width: 10),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      color: GColors.black,
                                      width: 50,
                                      height: 50,
                                    );
                                  },
                                ),
                              ),
                            )
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

//todo
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
      };

  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child; // Disable the default glow effect
  }
}
