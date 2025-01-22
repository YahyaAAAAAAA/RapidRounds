import 'package:rapid_rounds/config/enums/player_state.dart';

class Player {
  final String id; // Unique player ID
  final String name; // Player's name
  PlayerState state;
  int points; // Player's current score
  List<int> finishTimes; // Times taken to complete rounds (in seconds)
  List<bool> fails;

  Player({
    required this.id,
    required this.name,
    this.points = 0,
    this.state = PlayerState.playing,
    this.finishTimes = const [],
    this.fails = const [],
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      name: json['name'],
      points: json['points'] ?? 0,
      state: PlayerState.values.firstWhere((e) => e.name == json['state']),
      finishTimes: List<int>.from(json['finishTimes'] ?? []),
      fails: List<bool>.from(json['fails'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'points': points,
      'state': state.name,
      'finishTimes': finishTimes,
      'fails': fails,
    };
  }
}
