import 'package:rapid_rounds/features/room/domain/entities/room_with_players.dart';

abstract class RoomStates {}

class RoomInitial extends RoomStates {}

class RoomLoading extends RoomStates {}

class RoomCreated extends RoomStates {
  final String roomId;
  RoomCreated(this.roomId);
}

class RoomWaiting extends RoomStates {
  final RoomDetailed roomDetailed;
  RoomWaiting(this.roomDetailed);
}

class RoomInGame extends RoomStates {
  final RoomDetailed roomDetailed;

  RoomInGame(this.roomDetailed);
}

class RoomGameOver extends RoomStates {
  final RoomDetailed roomDetailed;
  RoomGameOver(this.roomDetailed);
}

class RoomDeleted extends RoomStates {}

class RoomError extends RoomStates {
  final String message;
  RoomError(this.message);
}

class RoomLeft extends RoomStates {}

class RoundDone extends RoomStates {}

class RoomBetweenRounds extends RoomStates {
  final RoomDetailed roomDetailed;
  final int minTime;

  RoomBetweenRounds(this.roomDetailed, this.minTime);
}
