import 'dart:convert';

import 'package:avo/constants/constants.dart';
import 'package:avo/model/user_model.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  Future<UserModel> signup({
    required String username,
    required String name,
    required String password,
    required String email
  })async{

    final response=await http.post(Uri.parse('${Constants.backendURI}/api/v1/users/signup'),
      headers: {
        'Content-Type':'application/json'
      },
      body: jsonEncode({
        'username':username,
        'name':name,
        'email':email,
        'password':password,
      })
    );
    final data=jsonDecode(response.body);
    if(response.statusCode!=201){
      throw data['message'];
    }

    //TODO: Store token in secure storage
    return UserModel.fromJSON(data['data']);
  }

  Future<UserModel>login({
    required String credential,
    required String password
  }) async {

    final response=await http.post(Uri.parse('${Constants.backendURI}/api/v1/users/login'),
      headers: {
        'Content-Type':'application/json'
      },
      body: jsonEncode({
        'credential':credential,
        'password':password
      })
    );
    final data=jsonDecode(response.body);
    if(response.statusCode!=200){
      throw data['message'];
    }
    //TODO: Store token in secure storage
    return UserModel.fromJSON(data['data']);
  }
}