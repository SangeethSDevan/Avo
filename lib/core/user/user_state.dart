import 'package:avo/model/user_model.dart';

sealed class UserState {}

class UserInit extends UserState{}

class UserLoading extends UserState{}

class UserLoggedIn extends UserState{
  final UserModel user;
  UserLoggedIn(this.user);
}

class UserLoggedOut extends UserState{}

class UserError extends UserState{
  final String message;
  UserError(this.message);
}