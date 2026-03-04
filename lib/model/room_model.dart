class RoomModel {
  final String roomId;
  final int duration;
  final int batchCount;
  final int breakCount;
  final List<String> users;
  final int readyCount;

  RoomModel({
    required this.roomId,
    required this.duration,
    required this.batchCount,
    required this.breakCount,
    required this.users,
    required this.readyCount
  });

  static RoomModel fromJSON(Map<String,dynamic> json){
    return RoomModel(
      roomId: json['roomId'], 
      duration: json['duration'], 
      batchCount: json['batchCount'], 
      breakCount: json['breakCount'], 
      users: List<String>.from(json['users']), 
      readyCount: json['readyCount']
    );
  }
}

class ActiveRoomModel extends RoomModel{
  final String type;
  final int startTime;
  final List<int> breaks;

  ActiveRoomModel({
    required this.type,
    required this.startTime,
    required this.breaks,
    required super.roomId,
    required super.duration,
    required super.batchCount,
    required super.breakCount,
    required super.users,
    required super.readyCount
  });

  static ActiveRoomModel fromJSON(Map<String,dynamic> json){
    return ActiveRoomModel(
      roomId: json['roomId'], 
      duration: json['duration'], 
      batchCount: json['batchCount'], 
      breakCount: json['breakCount'], 
      users: List<String>.from(json['users']), 
      readyCount: json['readyCount'],
      type: json['type'],
      startTime: json['startTime'],
      breaks: List<int>.from(json['breaks'])
    );
  }
}