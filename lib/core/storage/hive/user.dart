import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class Users extends HiveObject{

  @HiveField(0)
  late String userId;

  @HiveField(1)
  late String username;

  @HiveField(2)
  late String name;

  @HiveField(3)
  late String email;

  Users({
    required this.username,
    required this.email,
    required this.name,
    required this.userId
  });
}