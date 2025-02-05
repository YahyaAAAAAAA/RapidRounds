import 'package:rapid_rounds/features/games/game.dart';
import 'package:rapid_rounds/features/room/domain/entities/player.dart';
import 'package:rapid_rounds/features/room/domain/entities/room.dart';

class RoomDetailed {
  final Room room;
  final List<Player> players;
  final List<Game> games;

  RoomDetailed({
    required this.room,
    required this.players,
    required this.games,
  });
}
