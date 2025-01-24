import 'package:rapid_rounds/features/games/match%20color/color_match.dart';
import 'package:rapid_rounds/features/games/reaction%20button/reaction_button.dart';

abstract class Game {
  //not final because it's changed on room create
  String roomId;
  final String id;
  final String type;

  Game({
    required this.id,
    required this.type,
    required this.roomId,
  });

  factory Game.fromJson(Map<String, dynamic> data) {
    final type = data['type'];

    //todo comeback
    switch (type) {
      case 'ColorMatch':
        return ColorMatch.fromJson(data);
      case 'ReactionButton':
        return ReactionButton.fromJson(data);
      default:
        throw Exception('Unknown game type: $type');
    }
  }

  Map<String, dynamic> toJson();
}