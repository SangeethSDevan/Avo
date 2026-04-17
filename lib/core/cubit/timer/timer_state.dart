import 'package:avo/model/timer_stat_model.dart';

sealed class TimerState {}

class TimerUpdate extends TimerState{
  final int remainingTime;
  final double duration;
  
  TimerUpdate(TimerStatModel time)
    : remainingTime = time.remainingTime,
      duration = time.duration;
}

class TimerError extends TimerState{
  final String message;
  TimerError(this.message);
}

class TimerInit extends TimerState{}
