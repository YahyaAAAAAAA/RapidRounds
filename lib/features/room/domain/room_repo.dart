import 'package:rapid_rounds/features/games/game.dart';
import 'package:rapid_rounds/features/room/domain/entities/room_with_players.dart';

abstract class RoomRepo {
  Future<String> createRoom(
      String deviceId, String playerName, List<Game> games);

  Future<bool> joinRoom(String roomId, String deviceId, String playerName);

  Future<void> removePlayerFromRoom(String roomId, String playerId);

  Future<void> startGame(String roomId);

  Future<bool> isCreator(String roomId, String deviceId);

  Future<bool> isCreatorLeft(String roomId);

  Stream<RoomWithPlayers> listen(String roomId);

  Future<void> deleteRoom(String roomId);

  Future<void> nextRound(String roomId);

  Future<void> updatePlayerScore(
      String roomId, String playerId, int pointsToAdd);

  Future<void> onPlayerComplete(
    String roomId,
    String playerId,
    int? gameDelayMicroSeconds,
    bool? didFail,
  );

  Future<bool> isAllPlayersDone(String roomId);

  Future<void> resetPlayerState(String roomId);
}
