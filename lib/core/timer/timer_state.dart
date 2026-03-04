sealed class TimerState {}

class TimerUpdate extends TimerState{
  final int value;
  TimerUpdate(this.value);
}

class TimerError extends TimerState{
  final String message;
  TimerError(this.message);
}

class TimerInit extends TimerState{}
