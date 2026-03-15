import 'dart:async';
import 'package:avo/core/cubit/session/session_state.dart';
import 'package:avo/core/vibration/vibration_service.dart';
import 'package:avo/model/room_model.dart';
import 'package:avo/services/socket_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionCubit extends Cubit<SessionState> {
  final SocketService _socketService = SocketService();
  Timer? _timeOutTimer;

  SessionCubit() : super(SessionInit());

  void connect(){
    _socketService.connect();

    _socketService.onMatchFound = (RoomModel room){
      _timeOutTimer?.cancel();
      VibrationService.playVibration();
      emit(SessionFound(room));
    };

    _socketService.onError = (String message) {
      _timeOutTimer?.cancel();
      VibrationService.playVibration();
      emit(SessionError(message));
    };

    _socketService.onWaiting = () {
      emit(SessionWaiting());
    };

    _socketService.onStart = () {
      final currentState=state;
      if(currentState is SessionActive){
        VibrationService.playVibration();
        emit(SessionStarted(currentState.room));
      }
    };

    _socketService.onBreakStart = () {
      final currentState=state;
      if(currentState is SessionActive){
        VibrationService.playVibration();
        emit(SessionBreakStart(currentState.room));
      }
    };

    _socketService.onBreakEnd = () {
      final currentState=state;
      if(currentState is SessionActive){
        VibrationService.playVibration();
        emit(SessionBreakEnd(currentState.room));
      }
    };

    _socketService.onSessionEnd = () {
      emit(SessionEnded());
      VibrationService.playVibration();
    };

    _socketService.onSessionQuit = (String message) {
      emit(SessionQuit(message));
      VibrationService.playVibration();
    };
  }

  void findPartner(double duration,String category) {
    emit(SessionWaiting());
    _socketService.findPartner(duration,category);

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

  void startSession() {
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
