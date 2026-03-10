class RoomModel {
  final String roomId;
  final int duration;
  final String partner;

  RoomModel({
    required this.roomId,
    required this.duration,
    required this.partner
  });

  static RoomModel fromJSON(Map<String,dynamic> json){
    return RoomModel(
      roomId: json['roomId'], 
      duration: json['duration'], 
      partner: json['partner']
    );
  }
}
