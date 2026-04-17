class TimerStatModel {
  final int remainingTime;
  final double duration;

  TimerStatModel({
    required this.remainingTime,
    required this.duration
  });

  static TimerStatModel fromJSON(Map<String,dynamic> json){
    return TimerStatModel(remainingTime: json['remainingTime'], duration: json['duration']);
  }
}