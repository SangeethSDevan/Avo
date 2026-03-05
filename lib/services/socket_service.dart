import 'package:avo/constants/constants.dart';
import 'package:avo/model/room_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  Function(RoomModel room)? onMatchFound;
  Function(ActiveRoomModel room)? onStart;
  Function()? onWaiting;
  Function(String message)? onError;
  Function(ActiveRoomModel room)? onBreakStart;
  Function(ActiveRoomModel room)? onBreakEnd;
  Function()? onSessionEnd;
  Function(String message)? onSessionQuit;


  void connect(){
    socket=IO.io(Constants.backendURI);
    socket.connect();

    socket.onConnect((_){
      debugPrint("Connected to socket!");
    });

    socket.onDisconnect((_){
      debugPrint("Disconnected from socket!");
    });

    socket.on("MATCH_FOUND", (data){
      final room=RoomModel.fromJSON(data);
      onMatchFound?.call(room);
    });

    socket.on("WAITING_FOR_PARTNER", (_){
      onWaiting?.call();
    });

    socket.on("PARTNER_ERROR",(_){
      onError?.call("Looks like partner had left!");
    });

    socket.on("SESSION_STARTED",(data){
      final activeRoom=ActiveRoomModel.fromJSON(data);
      onStart?.call(activeRoom);
    });

    socket.on("SESSION_ENDED",(_){
      onSessionEnd?.call();
    });

    socket.on("SESSION_QUIT",(_){
      onSessionQuit?.call("Partner was disconnected from the session!");
    });

    socket.on("SESSION_LEFT",(_){
      onSessionQuit?.call("Partner had left before the session!");
    });

    socket.on("SESSION_STARTED",(data){
      final activeRoom=ActiveRoomModel.fromJSON(data);
      onStart?.call(activeRoom);
    });


    socket.on("BREAK_START",(data){
      final activeRoom=ActiveRoomModel.fromJSON(data);
      onBreakStart?.call(activeRoom);
    });

    socket.on("BREAK_END",(data){
      final activeRoom=ActiveRoomModel.fromJSON(data);
      onBreakEnd?.call(activeRoom);
    });

  }

  void findPartner(double duration){
    socket.emit("FIND_PARTNER",duration);
  }

  void startSession(String roomId){
    socket.emit("SOCKET_START",roomId);
  }

  void disconnect(){
    socket.disconnect();
  }
}
