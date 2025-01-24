import 'dart:math';

import 'package:rapid_rounds/features/games/game.dart';

class ReactionButton extends Game {
  int delay;

  ReactionButton({
    required super.id,
    required super.type,
    required super.roomId,
    int? delay,
  }) : delay = delay ?? Random().nextInt(4000000) + 2000000;

  ReactionButton.fromJson(Map<String, dynamic> json)
      : delay = json['delay'],
        super(
          id: json['id'],
          type: json['type'],
          roomId: json['roomId'],
        );

  @override
  Map<String, dynamic> toJson() {
    return {
      'delay': delay,
      'type': super.type,
      'id': super.id,
      'roomId': super.roomId,
    };
  }
}
