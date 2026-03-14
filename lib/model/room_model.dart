class RoomModel {
  final String roomId;
  final double duration;
  final PartnerModel partner;

  RoomModel({
    required this.roomId,
    required this.duration,
    required this.partner,
  });

  static RoomModel fromJSON(Map<String,dynamic> json){
    return RoomModel(
      roomId: json['roomId'], 
      duration: json['duration'], 
      partner: PartnerModel.fromJSON(json['partner']),
    );
  }
}

class PartnerModel{
  final String name;
  final String category;

  PartnerModel({required this.name,required this.category});
  static PartnerModel fromJSON(Map<String,dynamic> json){
    return PartnerModel(
      name: json['name'],
      category: json['category']
    );
  }
}