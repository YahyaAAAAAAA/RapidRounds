import 'package:rapid_rounds/features/games/game.dart';

class ColorMatch extends Game {
  final int gridSize;
  final List<int> colors;
  final List<int> palleteColors;

  ColorMatch({
    required super.id,
    required super.type,
    required super.roomId,
    required this.gridSize,
    required this.colors,
    required this.palleteColors,
  });

  ColorMatch.fromJson(Map<String, dynamic> json)
      : gridSize = json['gridSize'],
        colors = json['colors'],
        palleteColors = json['palleteColors'],
        super(
          id: json['id'],
          type: json['type'],
          roomId: json['roomId'],
        );

  @override
  Map<String, dynamic> toJson() {
    return {
      'gridSize': gridSize,
      'colors': colors,
      'palleteColors': palleteColors,
    };
  }
}
