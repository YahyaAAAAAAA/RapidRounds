import 'package:rapid_rounds/features/games/game.dart';
import 'package:rapid_rounds/features/room/domain/entities/player.dart';
import 'package:rapid_rounds/features/room/domain/entities/room.dart';

class RoomWithPlayers {
  final Room room;
  final List<Player> players;
  final List<Game> games;

  RoomWithPlayers({
    required this.room,
    required this.players,
    required this.games,
  });
}
