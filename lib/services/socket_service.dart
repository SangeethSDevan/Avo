import 'package:avo/constants/constants.dart';
import 'package:avo/core/storage/hive/user_controller.dart';
import 'package:avo/model/room_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  Function(RoomModel room)? onMatchFound;
  Function(RoomModel room)? onStart;
  Function()? onWaiting;
  Function(String message)? onError;
  Function(RoomModel room)? onBreakStart;
  Function(RoomModel room)? onBreakEnd;
  Function()? onSessionEnd;
  Function(String message)? onSessionQuit;

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

    socket.on("SESSION_STARTED", (data) {
      final activeRoom = RoomModel.fromJSON(data);
      onStart?.call(activeRoom);
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

    socket.on("SESSION_STARTED", (data) {
      final activeRoom =RoomModel.fromJSON(data);
      onStart?.call(activeRoom);
    });

    socket.on("BREAK_START", (data) {
      final activeRoom = RoomModel.fromJSON(data);
      onBreakStart?.call(activeRoom);
    });

    socket.on("BREAK_END", (data) {
      final activeRoom = RoomModel.fromJSON(data);
      onBreakEnd?.call(activeRoom);
    });
  }

  void waitingQuit(){
    socket.emit("SESSION_WAITING_LEFT");
  }

  void findPartner(double duration) {
    debugPrint("Func called with duration $duration");
    socket.emit("FIND_PARTNER", duration);
  }

  void startSession(String roomId) {
    socket.emit("SOCKET_START", roomId);
  }

  void disconnect() {
    socket.disconnect();
  }
}
