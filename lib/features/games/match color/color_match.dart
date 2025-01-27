import 'package:rapid_rounds/features/games/game.dart';

class ColorMatch extends Game {
  final int pattern;
  //fixed
  final int gridSize = 4;
  //the time before the game starts (micro)
  final int rememberTime = 3000000;
  //the time before the game ends (micro)
  final int solveTime = 10000000;

  ColorMatch({
    required super.id,
    required super.type,
    required super.roomId,
    required this.pattern,
  });

  ColorMatch.fromJson(Map<String, dynamic> json)
      : pattern = json['pattern'],
        super(
          id: json['id'],
          type: json['type'],
          roomId: json['roomId'],
        );

  @override
  Map<String, dynamic> toJson() {
    return {
      'pattern': pattern,
      'type': super.type,
      'id': super.id,
      'roomId': super.roomId,
    };
  }
}
