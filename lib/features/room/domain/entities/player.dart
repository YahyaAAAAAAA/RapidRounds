import 'package:rapid_rounds/config/enums/player_state.dart';

class Player {
  final String id;
  final String name;
  int avatar;
  PlayerState state;
  int points;
  List<int> finishTimes;
  List<bool> fails;

  Player({
    required this.id,
    required this.name,
    this.avatar = 0,
    this.points = 0,
    this.state = PlayerState.playing,
    this.finishTimes = const [],
    this.fails = const [],
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
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
      'avatar': avatar,
      'points': points,
      'state': state.name,
      'finishTimes': finishTimes,
      'fails': fails,
    };
  }
}
