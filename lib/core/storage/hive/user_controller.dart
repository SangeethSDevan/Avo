import 'package:avo/core/storage/hive/user.dart';
import 'package:avo/model/user_model.dart';
import 'package:hive/hive.dart';

class UserController {
  final userBox=Hive.box<Users>('user');

  UserModel? getUserData(){
    final user=userBox.get('user');
    if(user!=null){
      return UserModel(userId: user.userId, username: user.username, email: user.email, name: user.name);
    }
    return null;
  }
  void setUserData(UserModel user){
    userBox.clear();
    
    final userData=Users(userId: user.userId,email: user.email,username: user.username,name: user.name);
    userBox.put('user',userData);
  }
}