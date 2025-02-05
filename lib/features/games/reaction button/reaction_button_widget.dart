import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_rounds/config/utils/app_scaffold.dart';
import 'package:rapid_rounds/config/utils/constants.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';
import 'package:rapid_rounds/config/utils/pop_button.dart';
import 'package:rapid_rounds/features/games/reaction%20button/reaction_button.dart';
import 'package:rapid_rounds/features/home/presentation/components/main_menu_sub_appbar.dart';
import 'package:rapid_rounds/features/room/presentation/components/wait_text.dart';
import 'package:rapid_rounds/features/room/presentation/cubits/room_cubit.dart';

class ReactionButtonWidget extends StatefulWidget {
  final ReactionButton reactionButton;

  const ReactionButtonWidget({
    super.key,
    required this.reactionButton,
  });

  @override
  State<ReactionButtonWidget> createState() => _ReactionButtonWidgetState();
}

class _ReactionButtonWidgetState extends State<ReactionButtonWidget> {
  late final RoomCubit roomCubit;
  Timer? timer;
  bool hasAnswered = false;
  bool didFail = false;
  Color color = Colors.red;

  void onAnswer() async {
    if (hasAnswered) return;

    //player failed
    if (color == Colors.red) {
      didFail = true;
    }

    setState(() {
      hasAnswered = true;
    });

    // await widget.roomCubit
    //     .updatePlayerScore(widget.roomId, widget.roomCubit.deviceId, 10);

    await roomCubit.onPlayerComplete(
      widget.reactionButton.roomId,
      widget.reactionButton.delay,
      didFail,
    );

    roomCubit.isAllPlayersDone(widget.reactionButton.roomId);
  }

  void startGame() {
    timer = Timer(Duration(microseconds: widget.reactionButton.delay), () {
      setState(() {
        color = Colors.green;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    roomCubit = context.read<RoomCubit>();

    startGame();
  }

  @override
  void dispose() {
    timer!.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: MainMenuSubAppbar(
        text: 'ReactionButton',
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: kListViewWidth),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(8),
              children: [
                !hasAnswered
                    ? FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: GestureDetector(
                            onTap: () => onAnswer(),
                            child: PopButton.text(
                              onTapUp: null,
                              onTapDown: null,
                              backgroundColor: color,
                              depth: 10,
                              padding: EdgeInsets.all(50),
                              textColor: GColors.white,
                              fontWeight: FontWeight.bold,
                              textSize: 50,
                              text: color == Colors.red
                                  ? 'Wait for green'
                                  : 'Tap Now!',
                            ),
                          ),
                        ),
                      )
                    : WaitText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
