import 'package:avo/core/cubit/user/user_state.dart';
import 'package:avo/core/storage/hive/user_controller.dart';
import 'package:avo/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {

  final UserRepository _userRepository = UserRepository();
  final UserController _userController = UserController();

  UserCubit() : super(UserInit()) {
    _checkUser();
  }

  void _checkUser() {
    final user = _userController.getUserData();
    if (user != null) {
      emit(UserLoggedIn(user));
    }
  }

  Future<void> signup({
    required String username,
    required String name,
    required String email,
    required String password
  }) async {
    try {
      emit(UserLoading());

      final user = await _userRepository.signup(
        username: username,
        name: name,
        password: password,
        email: email,
      );

      _userController.setUserData(user);

      emit(UserLoggedIn(user));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }

  Future<void> login({
    required String credential,
    required String password
  }) async {
    try {
      emit(UserLoading());
      final user = await _userRepository.login(
        credential: credential,
        password: password,
      );
      _userController.setUserData(user);

      emit(UserLoggedIn(user));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }
  Future<void> logout()async{
    emit(UserLoggedOut());
    _userRepository.logout();
    _userController.clearData();
    emit(UserInit());
  }
}