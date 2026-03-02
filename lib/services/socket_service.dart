import 'package:avo/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void connect(){
    socket=IO.io(Constants.backendURI);
    socket.connect();

    socket.onConnect((_){
      debugPrint("Connected to socket!");
    });

    socket.onDisconnect((_){
      debugPrint("Disconnected from socket!");
    });
  }

    

  void disconnect(){
    socket.disconnect();
  }
}
