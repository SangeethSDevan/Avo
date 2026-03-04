import 'package:avo/core/user/user_state.dart';
import 'package:avo/model/user_model.dart';
import 'package:avo/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState>{
  UserCubit():super(UserInit());

  final UserRepository _userRepository=UserRepository();

  Future<void> signup({
    required String username,
    required String name,
    required String email,
    required String password
  })async{
    try{
      emit(UserLoading());
      final UserModel user=await _userRepository.signup(username: username, name: name, password: password, email: email);
      //TODO: Store logged user details in storage
      emit(UserLoggedIn(user));
    }catch(error){
      emit(UserError(error.toString()));
    }
  }

  Future<void> login({
    required String credential,
    required String password
  })async{
    try{
      emit(UserLoading());
      final UserModel user=await _userRepository.login(credential: credential, password: password);
      //TODO: Store logged user detauils in storage
      emit(UserLoggedIn(user));
    }catch(error){
      emit(UserError(error.toString()));
    }
  }
}