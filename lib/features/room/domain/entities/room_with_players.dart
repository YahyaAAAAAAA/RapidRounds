import 'package:rapid_rounds/features/room/domain/entities/player.dart';
import 'package:rapid_rounds/features/room/domain/entities/room.dart';

class RoomWithPlayers {
  final Room room;
  final List<Player> players;

  RoomWithPlayers({
    required this.room,
    required this.players,
  });
}
