import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_rounds/config/enums/room_state.dart';
import 'package:rapid_rounds/features/games/game.dart';
import 'package:rapid_rounds/features/games/reaction%20button/reaction_button.dart';
import 'package:rapid_rounds/features/room/domain/entities/player.dart';
import 'package:rapid_rounds/features/room/domain/room_repo.dart';
import 'package:rapid_rounds/features/room/presentation/cubits/room_state.dart';
import 'package:uuid/uuid.dart';

class RoomCubit extends Cubit<RoomStates> {
  final RoomRepo roomRepo;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String deviceId = const Uuid().v4();

  StreamSubscription? _roomSubscription;

  RoomCubit({required this.roomRepo}) : super(RoomInitial());

  Future<String> createRoom() async {
    try {
      final roomId = await roomRepo.createRoom(deviceId, generateGames());
      emit(RoomCreated(roomId));
      return roomId;
    } catch (e) {
      emit(RoomError(e.toString()));
      return '';
    }
  }

  List<Game> generateGames() {
    // final random = Random();
    final games = <Game>[];

    for (int i = 0; i < 30; i++) {
      // final gameType = random.nextInt(3);
      final gameType = 0;

      switch (gameType) {
        case 0:
          games.add(
            ReactionButton(
              id: i.toString(),
              roomId: 'temp',
              type: 'ReactionButton',
              delay: Random().nextInt(4000000) + 2000000,
            ),
          );
          break;
      }
    }

    return games;
  }

  Future<bool> joinRoom(String roomId) async {
    try {
      final isJoined = await roomRepo.joinRoom(roomId, deviceId);
      if (!isJoined) {
        emit(RoomError('Room not found'));
        return false;
      }
      return true;
    } catch (e) {
      emit(RoomError(e.toString()));
      return false;
    }
  }

  Future<void> leaveRoom(String roomId) async {
    try {
      await roomRepo.removePlayerFromRoom(roomId, deviceId);
      emit(RoomLeft());
    } catch (e) {
      emit(RoomError(e.toString()));
    }
  }

  /// Enhanced listener with stricter error handling
  Future<void> listenToRoom(String roomId) async {
    emit(RoomLoading());

    _roomSubscription = roomRepo.listen(roomId).listen(
      (roomWithPlayers) async {
        if (roomWithPlayers.room.state == RoomState.waiting) {
          emit(RoomWaiting(roomWithPlayers));
        } else if (roomWithPlayers.room.state == RoomState.betweenRounds) {
          //get min
          int min = getMinTime(roomWithPlayers.players);

          emit((RoomBetweenRounds(roomWithPlayers, min)));
        } else if (roomWithPlayers.room.state == RoomState.started) {
          emit(RoomInGame(roomWithPlayers));
        } else if (roomWithPlayers.room.state == RoomState.finished) {
          emit(RoomGameOver(roomWithPlayers));
        } else if (roomWithPlayers.room.state == RoomState.deleted) {
          emit(RoomDeleted());
          return;
        }
      },
      onError: (e) {
        emit(RoomError('Error syncing room: ${e.toString()}'));
      },
    );
  }

  int getMinTime(List<Player> players) {
    // Ensure there are players with non-empty finishTimes
    final validPlayers =
        players.where((player) => player.finishTimes.isNotEmpty).toList();

    if (validPlayers.isEmpty) {
      throw StateError('No player has a recorded finish time.');
    }

    //initialize min
    int min = Duration(days: 3000).inMicroseconds;

    // Iterate through the valid players to find the minimum time
    for (final player in validPlayers) {
      //failed player don't count
      if (player.fails.last) {
        continue;
      }
      if (player.finishTimes.last < min) {
        min = player.finishTimes.last;
      }
    }

    return min;
  }

  void isAllPlayersDone(String roomId) async {
    bool allPlayersDone = await roomRepo.isAllPlayersDone(roomId);

    if (allPlayersDone) {
      emit(RoundDone());
      await roomRepo.resetPlayerState(roomId);
    }
  }

  Future<bool> isCreator(String roomId) async {
    try {
      return await roomRepo.isCreator(roomId, deviceId);
    } catch (e) {
      emit(RoomError('Error checking creator status: ${e.toString()}'));
      return false;
    }
  }

  Future<void> startGame(String roomId) async {
    try {
      await roomRepo.startGame(roomId);
    } catch (e) {
      emit(RoomError('Error starting game: ${e.toString()}'));
    }
  }

  Future<void> nextRound(String roomId) async {
    try {
      await roomRepo.nextRound(roomId);
    } catch (e) {
      emit(RoomError('Error moving to next round: ${e.toString()}'));
    }
  }

  Future<void> updatePlayerScore(
      String roomId, String playerId, int score) async {
    try {
      await roomRepo.updatePlayerScore(roomId, playerId, score);
    } catch (e) {
      emit(RoomError('Error updating player score: ${e.toString()}'));
    }
  }

  Future<void> onPlayerComplete(
      String roomId, int? delay, bool? didFail) async {
    try {
      await roomRepo.onPlayerComplete(roomId, deviceId, delay, didFail);
    } catch (e) {
      emit(RoomError('Error moving to next round: ${e.toString()}'));
    }
  }

  @override
  Future<void> close() {
    _roomSubscription?.cancel();
    return super.close();
  }
}
