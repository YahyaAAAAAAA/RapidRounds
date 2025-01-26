import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/base_inkwell.dart';
import 'package:rapid_rounds/config/shadows.dart';
import 'package:rapid_rounds/features/games/match%20color/patterns.dart';

class ColorMatchWidget extends StatefulWidget {
  const ColorMatchWidget({super.key});

  @override
  State<ColorMatchWidget> createState() => _ColorMatchWidgetState();
}

//note for now size is 4 (fixed), but when not the rememberTime and solveTime should adapt.
class _ColorMatchWidgetState extends State<ColorMatchWidget> {
  static const int gridSize = 4;
  late List<Color> initialColors;
  late List<Color> currentGridColors;
  late List<Color> paletteColors;

  //
  bool hasAnswered = false;
  bool didFail = false;
  bool isHidden = false;
  Color? selectedColor;

  //the time before the game starts
  int rememberTime = 3000000; //db
  //the time before the game ends
  int solveTime = 3000000; //db

  @override
  void initState() {
    super.initState();
    initializeGame();

    //hide the grid colors after the reveal duration
    Future.delayed(Duration(microseconds: rememberTime), () {
      if (!mounted) {
        return;
      }
      setState(() {
        isHidden = true;
        currentGridColors = List.generate(
          gridSize * gridSize,
          (_) => Colors.grey.shade200,
        );
      });
    });
  }

  void initializeGame() {
    initialColors = generateRandomCommonColors(gridSize * gridSize);

    currentGridColors = List.from(initialColors);
    paletteColors = commonColors;
  }

  List<Color> commonColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    // Colors.yellow,
    // Colors.orange,
    // Colors.purple,
    // Colors.pink,
    // Colors.brown,
    // Colors.black,
    // Colors.white,
    // Colors.grey,
    // Colors.cyan,
    // Colors.teal,
    // Colors.indigo,
    // Colors.lime,
    // Colors.amber,
    // Colors.deepOrange,
    // Colors.deepPurple,
    // Colors.lightBlue,
    // Colors.lightGreen,
  ];

  List<Color> generateRandomCommonColors(int count) {
    int randomIndex = Random().nextInt(Patterns.patterns.length);

    return Patterns.patterns[randomIndex];
  }

  void onAnswer(int index) {
    if (hasAnswered) return;

    if (selectedColor != null) {
      setState(() {
        currentGridColors[index] = selectedColor!;
      });
    }

    if (listEquals(currentGridColors, initialColors)) {
      hasAnswered = true;
      didFail = false;
      print('won');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Grid Game'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 450),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(12),
            children: [
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
                    crossAxisCount: gridSize,
                  ),
                  itemCount: gridSize * gridSize,
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
              SizedBox(height: 30),
              Row(
                children: [
                  Icon(
                    Icons.draw_outlined,
                    color: Colors.black,
                  )
                ],
              ),
              SizedBox(height: 10),
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
                      commonColors.length,
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
      ),
    );
  }
}
