import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_rounds/config/enums/room_state.dart';
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
      final roomId = await roomRepo.createRoom(deviceId);
      emit(RoomCreated(roomId));
      return roomId;
    } catch (e) {
      emit(RoomError(e.toString()));
      return '';
    }
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

    // Initialize min with the first valid player's last finish time
    int min = validPlayers.first.finishTimes.last;

    // Iterate through the valid players to find the minimum time
    for (final player in validPlayers) {
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

  Future<void> onPlayerComplete(String roomId) async {
    try {
      await roomRepo.onPlayerComplete(roomId, deviceId, DateTime.now());
    } catch (e) {
      emit(RoomError('Error moving to next round: ${e.toString()}'));
    }
  }

  /// Synchronize mini-game state for all players
  Widget getMiniGameWidget(String roomId, int round) {
    final roomStream = roomRepo.listen(roomId);

    return StreamBuilder(
      stream: roomStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final roomWithPlayers = snapshot.data!;
        if (roomWithPlayers.room.currentRound < 1 ||
            roomWithPlayers.room.currentRound >
                roomWithPlayers.room.gameSequence.length) {
          return const Center(
              child: Text('No mini-game available for this round.'));
        }

        // Dynamically load the correct mini-game
        final miniGame = roomWithPlayers
            .room.gameSequence[roomWithPlayers.room.currentRound - 1];
        return Center(child: Text('Mini-Game: $miniGame'));
      },
    );
  }

  @override
  Future<void> close() {
    _roomSubscription?.cancel();
    return super.close();
  }
}
