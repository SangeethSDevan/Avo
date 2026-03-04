import 'package:avo/model/user_model.dart';

sealed class UserState {}

class UserInit extends UserState{}

class UserLoggedIn extends UserState{
  final UserModel user;
  UserLoggedIn(this.user);
}

class UserLoggedOut extends UserState{}