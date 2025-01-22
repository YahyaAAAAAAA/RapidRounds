import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class ColorGridScreen extends StatefulWidget {
  const ColorGridScreen({super.key});

  @override
  _ColorGridScreenState createState() => _ColorGridScreenState();
}

class _ColorGridScreenState extends State<ColorGridScreen> {
  static const int gridSize = 4;
  static const Duration revealDuration = Duration(seconds: 3);

  late List<Color> initialColors;
  late List<Color> currentGridColors;
  late List<Color> paletteColors;
  bool isHidden = false;
  Color? selectedColor;

  @override
  void initState() {
    super.initState();
    _initializeGame();

    // Hide the grid colors after the reveal duration
    Future.delayed(revealDuration, () {
      setState(() {
        isHidden = true;
        currentGridColors = List.generate(
          gridSize * gridSize,
          (_) => Colors.white,
        );
      });
    });
  }

  void _initializeGame() {
    final random = Random();

    initialColors = List.generate(
      gridSize * gridSize,
      (_) => Color.fromARGB(
        255,
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
      ),
    );

    currentGridColors = List.from(initialColors);
    paletteColors = List.from(initialColors)..shuffle(random);
  }

  void _recolorGrid(int index) {
    if (selectedColor != null) {
      setState(() {
        currentGridColors[index] = selectedColor!;
      });
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
          Expanded(
            flex: 2,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridSize,
              ),
              itemCount: gridSize * gridSize,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: isHidden ? () => _recolorGrid(index) : null,
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
