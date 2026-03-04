class UserModel {
  final String userId;
  final String username;
  final String name;
  final String email;

  UserModel({
    required this.userId,
    required this.username,
    required this.email,
    required this.name
  });

  static UserModel fromJSON(Map<String,dynamic> json){
    return UserModel(
      userId: json['userId'],
      username: json['username'],
      name: json['name'],
      email: json['email']
    );
  }
}
