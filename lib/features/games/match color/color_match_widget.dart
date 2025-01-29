import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_rounds/config/base_inkwell.dart';
import 'package:rapid_rounds/config/constants.dart';
import 'package:rapid_rounds/config/shadows.dart';
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

//note for now size is 4 (fixed), but when not the rememberTime and solveTime should adapt.
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
    paletteColors = roomCubit.commonColors;

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
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: Constants.listViewWidth),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(12),
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: Shadows.soft(),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.timelapse_rounded,
                      color: Colors.black,
                    ),
                    Text('  '),
                    Text(solveTime.toString()),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: Shadows.soft(),
              ),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: colorMatch.gridSize,
                ),
                itemCount: colorMatch.gridSize * colorMatch.gridSize,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BaseInkWell(
                        onTap: isHidden ? () => onAnswer(index) : null,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(bottom: 2),
                          decoration: BoxDecoration(
                            color: currentGridColors[index],
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: Shadows.soft(),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.draw_outlined,
                  color: Colors.black,
                )
              ],
            ),
            SizedBox(height: 5),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: Shadows.soft(),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    paletteColors.length,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColor = paletteColors[index];
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: paletteColors[index],
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: selectedColor == paletteColors[index]
                                ? Colors.black
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
