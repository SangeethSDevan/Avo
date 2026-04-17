import 'package:avo/constants/constants.dart';
import 'package:avo/core/storage/hive/user_controller.dart';
import 'package:avo/model/room_model.dart';
import 'package:avo/model/timer_stat_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance=SocketService._internal();
  factory SocketService()=>_instance;

  SocketService._internal();

  late IO.Socket socket;

  Function(RoomModel room)? onMatchFound;
  Function()? onStart;
  Function()? onWaiting;
  Function(String message)? onError;
  Function()? onBreakStart;
  Function()? onBreakEnd;
  Function()? onSessionEnd;
  Function(String message)? onSessionQuit;
  Function(TimerStatModel time)? onTimerUpdate;

  void connect() {
    final userController=UserController();
    final user=userController.getUserData();

    debugPrint("Connect called!");
    socket = IO.io(
      Constants.backendURI,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setAuth({'userId':user!.userId})
          .disableAutoConnect()
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      debugPrint("Connected to socket!");
    });

    socket.onDisconnect((_) {
      debugPrint("Disconnected from socket!");
    });

    socket.on("MATCH_FOUND", (data) {
      final room = RoomModel.fromJSON(data);
      onMatchFound?.call(room);
    });

    socket.on("WAITING_FOR_PARTNER", (_) {
      onWaiting?.call();
    });

    socket.on("PARTNER_ERROR", (_) {
      onError?.call("Looks like partner had left!");
    });

    socket.on("SESSION_STARTED", (_) {
      onStart?.call();
    });

    socket.on("SESSION_ENDED", (_) {
      onSessionEnd?.call();
    });

    socket.on("SESSION_QUIT", (_) {
      onSessionQuit?.call("Partner was disconnected from the session!");
    });

    socket.on("SESSION_LEFT", (_) {
      onSessionQuit?.call("Partner had left before the session!");
    });

    socket.on("BREAK_START", (data) {
      onBreakStart?.call();
    });

    socket.on("BREAK_END", (data) {
      onBreakEnd?.call();
    });

    socket.on("TIMER_STAT", (remainingTime){
      final time=TimerStatModel.fromJSON(remainingTime);
      final duration=Duration(milliseconds: time.remainingTime);
      onTimerUpdate?.call(time);      
      print('${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}');
    });
  }

  void sessionQuit(){
    socket.emit("SESSION_EXIT");
  }

  void findPartner(double duration,String category) {
    socket.emit("FIND_PARTNER",{
      "duration":duration,
      "category":category
    });
  }

  void startSession(String roomId) {
    socket.emit("SESSION_START", roomId);
  }

  void disconnect() {
    socket.disconnect();
  }
}
