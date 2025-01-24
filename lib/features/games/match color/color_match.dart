import 'dart:ui';

import 'package:rapid_rounds/features/games/game.dart';

class ColorMatch extends Game {
  List<Color> colors = [];

  ColorMatch({
    required super.id,
    required super.type,
    required super.roomId,
  });

  ColorMatch.fromJson(Map<String, dynamic> json)
      : colors = List<Color>.from(json['colors']),
        super(
          id: json['id'],
          type: json['type'],
          roomId: json['roomId'],
        );

  @override
  Map<String, dynamic> toJson() {
    return {
      'colors': colors,
    };
  }
}
