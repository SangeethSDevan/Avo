import 'package:avo/core/cubit/timer/timer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerCubit extends Cubit<TimerState>{
  TimerCubit():super(TimerInit());

  void setTimer(int value){
    emit(TimerUpdate(value));
  }

  void timerError(String message){
    emit(TimerError(message));
  }
}