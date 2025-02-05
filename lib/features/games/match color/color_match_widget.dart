import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_rounds/config/utils/constants.dart';
import 'package:rapid_rounds/config/utils/global_colors.dart';
import 'package:rapid_rounds/config/utils/pop_button.dart';
import 'package:rapid_rounds/features/games/game_widget.dart';
import 'package:rapid_rounds/features/games/match%20color/color_match.dart';
import 'package:rapid_rounds/features/games/match%20color/patterns.dart';
import 'package:rapid_rounds/features/room/presentation/cubits/room_cubit.dart';

class ColorMatchWidget extends StatefulWidget {
  final ColorMatch colorMatch;

  const ColorMatchWidget({
    super.key,
    required this.colorMatch,
  });

  @override
  State<ColorMatchWidget> createState() => _ColorMatchWidgetState();
}

class _ColorMatchWidgetState extends State<ColorMatchWidget> {
  late final RoomCubit roomCubit;
  late final ColorMatch colorMatch;
  late List<Color> initialColors;
  late List<Color> currentGridColors;
  late List<Color> paletteColors;
  bool hasAnswered = false;
  bool didFail = false;
  bool isHidden = false;
  int solveTime = 0;
  Color? selectedColor;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    //get cubit
    roomCubit = context.read<RoomCubit>();

    colorMatch = widget.colorMatch;

    //micro to secs
    solveTime = (colorMatch.solveTime / 1000000).toInt();

    //init game
    initialColors = Patterns.patterns[colorMatch.pattern];
    currentGridColors = List.from(initialColors);
    paletteColors = [
      Colors.red,
      Colors.blue,
      Colors.green,
    ];

    //hide the grid colors after the reveal duration
    Future.delayed(Duration(microseconds: colorMatch.rememberTime), () {
      if (!mounted) return;

      setState(() {
        isHidden = true;
        currentGridColors = List.generate(
          colorMatch.gridSize * colorMatch.gridSize,
          (_) => Colors.grey.shade200,
        );
      });
      //start limit timer
      startTimer();
    });
  }

  @override
  void dispose() {
    if (timer != null) {
      timer?.cancel();
    }

    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (!mounted) return;

      setState(() {
        solveTime--;
      });

      if (solveTime == 0 && hasAnswered == false) {
        timer.cancel();
        hasAnswered = true;
        didFail = true;
        await roomCubit.onPlayerComplete(
          widget.colorMatch.roomId,
          widget.colorMatch.rememberTime,
          didFail,
        );

        roomCubit.isAllPlayersDone(colorMatch.roomId);
      }
    });
  }

  void onAnswer(int index) async {
    if (hasAnswered) return;

    if (selectedColor != null) {
      setState(() {
        currentGridColors[index] = selectedColor!;
      });
    }

    if (listEquals(currentGridColors, initialColors) && (solveTime != 0)) {
      hasAnswered = true;
      didFail = false;

      await roomCubit.onPlayerComplete(
        widget.colorMatch.roomId,
        widget.colorMatch.rememberTime,
        didFail,
      );

      roomCubit.isAllPlayersDone(colorMatch.roomId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      title: 'ColorMatch',
      solveTime: solveTime,
      children: [
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: GColors.gray,
            borderRadius: BorderRadius.circular(kOutterRadius),
          ),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: colorMatch.gridSize,
            ),
            itemCount: colorMatch.gridSize * colorMatch.gridSize,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(15),
                child: PopButton.child(
                  onTapUp: isHidden ? () => onAnswer(index) : () {},
                  backgroundColor: currentGridColors[index],
                  depth: 5,
                  child: SizedBox(
                    width: 20,
                    height: 20,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 5),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Icon(
                Icons.draw_outlined,
                color: Colors.black,
              )
            ],
          ),
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: GColors.gray,
                  borderRadius: BorderRadius.circular(kOutterRadius),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 15,
                  children: List.generate(
                    paletteColors.length,
                    (index) => PopButton.child(
                      backgroundColor: paletteColors[index],
                      onTapUp: () =>
                          setState(() => selectedColor = paletteColors[index]),
                      border: Border.all(
                        color: selectedColor == paletteColors[index]
                            ? Colors.black
                            : Colors.transparent,
                        width: 2,
                      ),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
