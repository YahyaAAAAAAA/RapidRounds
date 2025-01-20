import 'package:rapid_rounds/config/enums/room_state.dart';

class Room {
  String id;
  RoomState state; // Room state: Waiting, InGame, GameOver
  String creator; // ID of the room creator
  int currentRound; // Current round number
  int totalRounds; // Total number of rounds
  String currentMiniGame; // ID of the current mini-game
  List<String> gameSequence; // Sequence of mini-games for this room
  DateTime roundStartTime; // Time when the current round started

  Room({
    required this.id,
    required this.state,
    required this.creator,
    required this.roundStartTime,
    this.currentRound = 0,
    this.totalRounds = 3,
    this.currentMiniGame = "",
    this.gameSequence = const [],
  });

  Room.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        state = RoomState.values.firstWhere((e) => e.name == json['state']),
        creator = json['creator'],
        currentRound = json['currentRound'] ?? 0,
        totalRounds = json['totalRounds'] ?? 3,
        currentMiniGame = json['currentMiniGame'] ?? "",
        gameSequence = List<String>.from(json['gameSequence'] ?? []),
        roundStartTime = json['roundStartTime'].toDate();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'state': state.name,
      'creator': creator,
      'currentRound': currentRound,
      'totalRounds': totalRounds,
      'currentMiniGame': currentMiniGame,
      'gameSequence': gameSequence,
      'roundStartTime': roundStartTime,
    };
  }
}
