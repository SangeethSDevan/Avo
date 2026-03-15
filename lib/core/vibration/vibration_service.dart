import 'package:vibration/vibration.dart';

class VibrationService {
  static Future<void> playVibration() async{
    if(await Vibration.hasVibrator()){
      Vibration.vibrate();
    }
  }
}