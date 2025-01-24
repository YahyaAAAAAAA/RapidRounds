import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rapid_rounds/features/games/reaction%20button/reaction_button.dart';
import 'package:rapid_rounds/features/room/presentation/cubits/room_cubit.dart';

class ReactionButtonWidget extends StatefulWidget {
  final ReactionButton reactionButton;
  final RoomCubit roomCubit; //should be local ?

  const ReactionButtonWidget({
    super.key,
    required this.reactionButton,
    required this.roomCubit,
  });

  @override
  State<ReactionButtonWidget> createState() => _ReactionButtonWidgetState();
}

class _ReactionButtonWidgetState extends State<ReactionButtonWidget> {
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

    await widget.roomCubit.onPlayerComplete(
      widget.reactionButton.roomId,
      widget.reactionButton.delay,
      didFail,
    );

    widget.roomCubit.isAllPlayersDone(widget.reactionButton.roomId);
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

    startGame();
  }

  @override
  void dispose() {
    timer!.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !hasAnswered
        ? GestureDetector(
            onTap: () => onAnswer(),
            child: Container(
              color: color,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      color == Colors.red ? 'Wait for green' : 'Tap Now!',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          )
        : Center(
            child: Text(
              'Please Wait for other Players',
            ),
          );
  }
}
