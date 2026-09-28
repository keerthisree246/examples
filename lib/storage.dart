import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Shared {
  final FlutterSecureStorage storage= FlutterSecureStorage();
  Future<void> setStorage(String token)async{
    await storage.write(key: 'user', value: token);
  }
  Future<String?> getStorage()async{
    return  await storage.read(key: 'user');
  }
  
}
// final prefs = await SharedPreferences.getInstance();

// await prefs.setBool('isLoggedIn', true);

// final value = prefs.getBool('isLoggedIn') ?? false;