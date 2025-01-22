import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rapid_rounds/config/enums/player_state.dart';
import 'package:rapid_rounds/config/enums/room_state.dart';
import 'package:rapid_rounds/features/room/domain/entities/player.dart';
import 'package:rapid_rounds/features/room/domain/entities/room.dart';
import 'package:rapid_rounds/features/room/domain/entities/room_with_players.dart';
import 'package:rapid_rounds/features/room/domain/room_repo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class FirebaseRoomRepo implements RoomRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<String> createRoom(String deviceId) async {
    final roomId = const Uuid().v4().substring(0, 6).toUpperCase();

    // Generate a randomized sequence of mini-games
    final shuffledGames = ['game1', 'game2', 'game3']..shuffle();

    await firestore.collection('rooms').doc(roomId).set({
      'id': roomId,
      'creator': deviceId,
      'state': RoomState.waiting.name,
      'currentRound': 0,
      'totalRounds': 3,
      'currentMiniGame': '',
      'gameSequence': shuffledGames,
      'roundStartTime': FieldValue.serverTimestamp(),
      //todo should be dynamic based on number of games that requires delay
      'delays': [Random().nextInt(4000000) + 2000000],
    });
    //print success

    await firestore
        .collection('rooms')
        .doc(roomId)
        .collection('players')
        .doc(deviceId)
        .set({
      'id': deviceId,
      'name': 'playerName 1',
      'points': 0,
      'state': PlayerState.playing.name,
      'finishTimes': <int>[],
      'fails': <bool>[],
    });

    return roomId;
  }

  @override
  Future<bool> isCreatorLeft(String roomId) async {
    final docRef = firestore.collection('rooms').doc(roomId);
    final doc = await docRef.get();

    if (!doc.exists) {
      throw Exception("Room does not exist.");
    }

    final roomData = doc.data()!;
    final List<dynamic> playersList = roomData['players'] as List<dynamic>;

    //locate creator in the players list
    final creatorIndex = playersList.indexWhere((player) {
      if (player is Map<String, dynamic>) {
        return player['id'] == roomData['creator'];
      }
      return false;
    });

    if (creatorIndex == -1) {
      //creator left
      return true;
    }

    //creator in-room
    return false;
  }

  //TODO
  @override
  Future<void> removePlayerFromRoom(String roomId, String deviceId) async {
    final docRef = firestore.collection('rooms').doc(roomId);
    final doc = await docRef.get();

    if (!doc.exists) {
      throw Exception("Room does not exist.");
    }

    final roomData = doc.data()!;
    final List<dynamic> playersList = roomData['players'] as List<dynamic>;

    //locate player in the players list
    final playerIndex = playersList.indexWhere((player) {
      if (player is Map<String, dynamic>) {
        return player['id'] == deviceId;
      }
      return false;
    });

    if (playerIndex == -1) {
      throw Exception("Player not found in the room.");
    }

    // Remove the player
    playersList.removeAt(playerIndex);

    // Update the room with the new players list
    await docRef.update({
      'players': playersList,
    });
  }

  @override
  Future<void> deleteRoom(String roomId) async {
    final docRef = firestore.collection('rooms').doc(roomId);

    await docRef.delete();
  }

  @override
  Future<bool> joinRoom(String roomId, String deviceId) async {
    final docRef = firestore.collection('rooms').doc(roomId);
    final doc = await docRef.get();

    if (!doc.exists) {
      return false;
    }

    // Create the new player object with initialized points
    final newPlayer = {
      'id': deviceId,
      'name': 'playerName', //todo
      'points': 0,
      'state': PlayerState.playing.name,
      'finishTimes': <int>[],
      'fails': <bool>[],
    };

    // Add the player to the players list using arrayUnion
    await docRef.collection('players').doc(deviceId).set(newPlayer);

    return true;
  }

  @override
  Stream<RoomWithPlayers> listen(String roomId) {
    final roomRef = FirebaseFirestore.instance.collection('rooms').doc(roomId);
    final playersRef = roomRef.collection('players');

    // Listen to the room document
    final roomStream = roomRef.snapshots().map((snapshot) {
      if (!snapshot.exists) {
        throw Exception('Room with ID $roomId does not exist');
      }

      final data = snapshot.data();
      if (data == null) {
        throw Exception('Room with ID $roomId does not exist');
      }

      return Room.fromJson(data);
    });

    // Listen to the players subcollection
    final playersStream = playersRef.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Player.fromJson(data);
      }).toList();
    });

    // Combine the room and players streams into one
    return Rx.combineLatest2(roomStream, playersStream,
        (Room room, List<Player> players) {
      return RoomWithPlayers(room: room, players: players);
    });
  }

  @override
  Future<void> startGame(String roomId) async {
    final roomRef = firestore.collection('rooms').doc(roomId);

    // Fetch the game sequence
    final doc = await roomRef.get();
    if (!doc.exists) {
      throw Exception('Room does not exist.');
    }

    final data = doc.data()!;
    final gameSequence = List<String>.from(data['gameSequence'] ?? []);

    if (gameSequence.isEmpty) {
      throw Exception('Game sequence is not defined.');
    }

    await roomRef.update({
      'state': RoomState.started.name,
      'currentRound': 1,
      'roundState': 'InProgress',
      'currentMiniGame': gameSequence.first,
      'roundStartTime': FieldValue.serverTimestamp(),
    });
  }

  //get room creator id
  @override
  Future<bool> isCreator(String roomId, String deviceId) async {
    final doc = await firestore.collection('rooms').doc(roomId).get();

    if (!doc.exists) {
      return false;
    }

    final data = doc.data();

    if (data == null) {
      return false;
    }

    final creator = data['creator'];

    return deviceId == creator;
  }

  @override
  Future<void> nextRound(String roomId) async {
    final roomRef = firestore.collection('rooms').doc(roomId);

    final doc = await roomRef.get();
    if (!doc.exists) {
      throw Exception('Room does not exist.');
    }

    final data = doc.data()!;
    final currentRound = data['currentRound'] ?? 0;
    final totalRounds = data['totalRounds'] ?? 3;
    final gameSequence = List<String>.from(data['gameSequence'] ?? []);

    if (currentRound >= totalRounds) {
      // End the game
      await roomRef.update({
        'state': RoomState.finished.name,
      });
    } else {
      // Move to the next round
      await roomRef.update({
        'state': RoomState.betweenRounds.name,
        'currentRound': currentRound + 1,
        'currentMiniGame': gameSequence[currentRound],
      });
    }

    await Future.delayed(
      Duration(seconds: 3),
      () async {
        // await roomRef.update({
        //   'state': RoomState.started.name,
        //   'roundStartTime': FieldValue.serverTimestamp(),
        // });
      },
    );
  }

  //todo
  @override
  Future<void> updatePlayerScore(
      String roomId, String playerId, int pointsToAdd) async {
    final roomRef = firestore.collection('rooms').doc(roomId);

    // Fetch the current room data
    final doc = await roomRef.get();
    if (!doc.exists) {
      throw Exception('Room does not exist.');
    }

    final data = doc.data()!;
    final players = List<Map<String, dynamic>>.from(data['players'] ?? []);

    // Find the player and update their score
    final playerIndex = players.indexWhere((p) => p['id'] == playerId);
    if (playerIndex == -1) {
      throw Exception('Player not found.');
    }

    final currentPoints =
        players[playerIndex]['points'] ?? 0; // Default to 0 if null
    players[playerIndex]['points'] = currentPoints + pointsToAdd;

    // Update the players list in Firestore
    await roomRef.update({
      'players': players,
    });
  }

  @override
  Future<void> onPlayerComplete(
    String roomId,
    String playerId,
    int? gameDelayMicroSeconds,
    bool? didFail,
  ) async {
    final roomRef = FirebaseFirestore.instance.collection('rooms').doc(roomId);
    final playerRef = roomRef.collection('players').doc(playerId);

    final DateTime delayStart = DateTime.now().toUtc();

    // Fetch the room document
    final roomSnapshot = await roomRef.get();
    if (!roomSnapshot.exists) {
      throw Exception('Room with ID $roomId does not exist.');
    }

    final roomData = roomSnapshot.data();
    if (roomData == null) {
      throw Exception('Room data is missing.');
    }

    // Get the centralized round start time
    final Timestamp? roundStartTimeTimestamp = roomData['roundStartTime'];
    if (roundStartTimeTimestamp == null) {
      throw Exception('Round start time is missing.');
    }

    final DateTime roundStartTime = roundStartTimeTimestamp.toDate().toUtc();

    // Store the server timestamp in the player's document
    await playerRef.update({
      'state': PlayerState.done.name,
      'completionTime': FieldValue.serverTimestamp(),
    });

    final DateTime delayEnd = DateTime.now().toUtc();

    // Fetch the updated player document to get the server timestamp
    final updatedPlayerSnapshot = await playerRef.get();
    final updatedPlayerData = updatedPlayerSnapshot.data();
    if (updatedPlayerData == null) {
      throw Exception('Player data is missing after update.');
    }

    final Timestamp? completionTimestamp = updatedPlayerData['completionTime'];
    if (completionTimestamp == null) {
      throw Exception('Completion time is missing.');
    }

    final DateTime completionTime = completionTimestamp.toDate().toUtc();

    // Calculate the time difference
    final int elapsedMicroSeconds =
        completionTime.difference(roundStartTime).inMicroseconds;

    final int elapsedDelayMicroSeconds =
        delayEnd.difference(delayStart).inMicroseconds;

    // ignore: avoid_print
    print('Start Time $roundStartTime');
    // ignore: avoid_print
    print('Finish Time $completionTime');
    // ignore: avoid_print
    print('Elapsed Player Microseconds $elapsedMicroSeconds');
    // ignore: avoid_print
    print('Elapsed Server Delay Microseconds $elapsedDelayMicroSeconds');
    // ignore: avoid_print
    print('Elapsed Delay Microseconds $gameDelayMicroSeconds');

    // Append the elapsedSeconds to the finishTime list
    final List<int> finishTimes =
        List<int>.from(updatedPlayerData['finishTimes'] ?? []);
    finishTimes.add(elapsedMicroSeconds -
        elapsedDelayMicroSeconds -
        (gameDelayMicroSeconds ?? 0));

    //add to fails
    final List<bool> fails = List<bool>.from(updatedPlayerData['fails'] ?? []);

    fails.add(didFail ?? false);

    // Update the finishTime list in the player's document
    await playerRef.update({
      'finishTimes': finishTimes,
      'fails': fails,
    });
  }

  //is all players done
  @override
  Future<bool> isAllPlayersDone(String roomId) async {
    final playersDoc = await firestore
        .collection('rooms')
        .doc(roomId)
        .collection('players')
        .get();

    final players = playersDoc.docs.map((doc) => doc.data()).toList();

    return players.every((player) {
      return player['state'] == PlayerState.done.name;
    });
  }

  //reset all players state to playing
  @override
  Future<void> resetPlayerState(String roomId) async {
    final playersDoc = await firestore
        .collection('rooms')
        .doc(roomId)
        .collection('players')
        .get();

    final players = playersDoc.docs.map((doc) => doc.data()).toList();

    for (final player in players) {
      await firestore
          .collection('rooms')
          .doc(roomId)
          .collection('players')
          .doc(player['id'])
          .update({
        'state': PlayerState.playing.name,
      });
    }
  }
}
