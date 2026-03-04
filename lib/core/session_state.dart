import 'package:avo/model/room_model.dart';

sealed class SessionState {}

class SessionInit extends SessionState{}

class SessionLoading extends SessionState{}

class SessionFound extends SessionState{
  final RoomModel room;
  SessionFound(this.room);
}

class SessionStarted extends SessionState{
  final ActiveRoomModel room;
  SessionStarted(this.room);
}

class SessionWaiting extends SessionState{}

class SessionQuit extends SessionState{
  final String message;
  SessionQuit(this.message);
}

class SessionBreakStart extends SessionState{
  final ActiveRoomModel room;
  SessionBreakStart(this.room);
}

class SessionBreakEnd extends SessionState{
  final ActiveRoomModel room;
  SessionBreakEnd(this.room);
}

class SessionEnded extends SessionState{}

class SessionError extends SessionState{
  final String message;
  SessionError(this.message);
}