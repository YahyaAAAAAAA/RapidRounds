import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ColorMatchWidget extends StatefulWidget {
  const ColorMatchWidget({super.key});

  @override
  State<ColorMatchWidget> createState() => _ColorMatchWidgetState();
}

class _ColorMatchWidgetState extends State<ColorMatchWidget> {
  static const int gridSize = 4;
  late List<Color> initialColors;
  late List<Color> currentGridColors;
  late List<Color> paletteColors;
  //TODO DO THE GAME
  //
  bool hasAnswered = false;
  bool didFail = false;
  bool isHidden = false;
  int delay = 3000000;
  Color? selectedColor;

  @override
  void initState() {
    super.initState();
    initializeGame();

    //hide the grid colors after the reveal duration
    Future.delayed(Duration(microseconds: delay), () {
      setState(() {
        isHidden = true;
        currentGridColors = List.generate(
          gridSize * gridSize,
          (_) => Colors.white,
        );
      });
    });
  }

  void initializeGame() {
    final random = Random();

    initialColors = generateRandomCommonColors(count: gridSize * gridSize);

    currentGridColors = List.from(initialColors);
    paletteColors = List.from(initialColors)..shuffle(random);
  }

  List<Color> generateRandomCommonColors({int count = 5}) {
    List<Color> commonColors = [
      Colors.red,
      // Colors.blue,
      // Colors.green,
      Colors.yellow,
      // Colors.orange,
      //
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

    Random random = Random();
    List<Color> randomColors = [];
    Set<int> usedIndices = {}; // To track used indices and avoid duplicates

    while (randomColors.length < count) {
      int randomIndex = random.nextInt(commonColors.length);

      usedIndices.add(randomIndex);
      randomColors.add(commonColors[randomIndex]);
    }

    return randomColors;
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Grid Game'),
      ),
      body: Column(
        children: [
          SizedBox(
            width: 500,
            height: 500,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridSize,
              ),
              itemCount: gridSize * gridSize,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: isHidden ? () => onAnswer(index) : null,
                  child: Container(
                    margin: EdgeInsets.all(4),
                    color: currentGridColors[index],
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: paletteColors.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedColor = paletteColors[index];
                    });
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: paletteColors[index],
                      border: Border.all(
                        color: selectedColor == paletteColors[index]
                            ? Colors.black
                            : Colors.transparent,
                        width: 3,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
