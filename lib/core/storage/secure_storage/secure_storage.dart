import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage=FlutterSecureStorage();

  Future<void> setToken(String token)async{
    await _storage.write(key: 'JWT', value: token);
  }

  Future<String?> getToken()async{
    return await _storage.read(key: 'JWT');
  }
  Future<void> clearToken()async{
    await _storage.delete(key: 'JWT');
  }
}