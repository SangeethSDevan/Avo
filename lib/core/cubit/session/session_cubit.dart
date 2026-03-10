import 'dart:async';
import 'package:avo/core/cubit/session/session_state.dart';
import 'package:avo/model/room_model.dart';
import 'package:avo/services/socket_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionCubit extends Cubit<SessionState> {
  final SocketService _socketService = SocketService();
  Timer? _timeOutTimer;

  SessionCubit() : super(SessionInit());

  void connect(){
    _socketService.connect();

    _socketService.onMatchFound = (RoomModel room) {
      _timeOutTimer?.cancel();
      emit(SessionFound(room));
    };

    _socketService.onError = (String message) {
      _timeOutTimer?.cancel();
      emit(SessionError(message));
    };

    _socketService.onWaiting = () {
      emit(SessionWaiting());
    };

    _socketService.onStart = (RoomModel room) {
      emit(SessionStarted(room));
    };

    _socketService.onBreakStart = (RoomModel room) {
      emit(SessionBreakStart(room));
    };

    _socketService.onBreakEnd = (RoomModel room) {
      emit(SessionBreakEnd(room));
    };

    _socketService.onSessionEnd = () {
      emit(SessionEnded());
    };

    _socketService.onSessionQuit = (String message) {
      emit(SessionQuit(message));
    };
  }

  void findPartner(double duration) {
    emit(SessionWaiting());
    _socketService.findPartner(duration);

    _timeOutTimer?.cancel();
    _timeOutTimer = Timer(const Duration(minutes: 1), () {
      if (state is SessionWaiting) {
        _socketService.waitingQuit();
        emit(
          SessionQuit("#NOT_FOUND"),
        );
      }
    });
  }

  bool isConnected(){
    return _socketService.socket.connected;
  }

  void startSession(String roomId) {
    if (!_socketService.socket.connected) emit(SessionError("Socket not created yet!"));
    if(state is SessionFound){
      final room=(state as SessionFound).room;
      emit(SessionConfirm(room));
      _socketService.startSession(room.roomId);
    }
  }

  void waitingQuit(){
    _socketService.waitingQuit();
  }
}
