import 'package:rapid_rounds/features/room/domain/entities/room_with_players.dart';

abstract class RoomStates {}

class RoomInitial extends RoomStates {}

class RoomLoading extends RoomStates {}

class RoomCreated extends RoomStates {
  final String roomId;
  RoomCreated(this.roomId);
}

class RoomWaiting extends RoomStates {
  final RoomWithPlayers roomWithPlayers;
  RoomWaiting(this.roomWithPlayers);
}

class RoomInGame extends RoomStates {
  final RoomWithPlayers roomWithPlayers;

  RoomInGame(this.roomWithPlayers);
}

class RoomGameOver extends RoomStates {
  final RoomWithPlayers roomWithPlayers;
  RoomGameOver(this.roomWithPlayers);
}

class RoomDeleted extends RoomStates {}

class RoomError extends RoomStates {
  final String message;
  RoomError(this.message);
}

class RoomLeft extends RoomStates {}

class RoundDone extends RoomStates {}

class RoomBetweenRounds extends RoomStates {
  final RoomWithPlayers roomWithPlayers;
  final int minTime;

  RoomBetweenRounds(this.roomWithPlayers, this.minTime);
}
