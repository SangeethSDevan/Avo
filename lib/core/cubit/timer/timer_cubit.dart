import 'package:avo/core/cubit/timer/timer_state.dart';
import 'package:avo/model/timer_stat_model.dart';
import 'package:avo/services/socket_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerCubit extends Cubit<TimerState>{
  TimerCubit():super(TimerInit()){
    final socketService=SocketService();

    socketService.onTimerUpdate=(TimerStatModel time){
      emit(TimerUpdate(time));
    };
  }

  void timerError(String message){
    emit(TimerError(message));
  }
}