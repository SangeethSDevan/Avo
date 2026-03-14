import 'package:avo/model/room_model.dart';

sealed class SessionState {}

class SessionInit extends SessionState{}

class SessionLoading extends SessionState{}

class SessionActive extends SessionState{
  final RoomModel room;
  SessionActive(this.room);
}

class SessionFound extends SessionActive{
  SessionFound(super.room);
}

class SessionConfirm extends SessionActive{
  SessionConfirm(super.room);
}

class SessionStarted extends SessionActive{
  SessionStarted(super.room);
}

class SessionQuit extends SessionState{
  final String message;
  SessionQuit(this.message);
}

class SessionBreakStart extends SessionActive{
  SessionBreakStart(super.room);
}

class SessionBreakEnd extends SessionActive{
  SessionBreakEnd(super.room);
}

class SessionEnded extends SessionState{}

class SessionWaiting extends SessionState{}

class SessionError extends SessionState{
  final String message;
  SessionError(this.message);
}