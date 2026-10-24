import 'dart:convert';
import 'package:example/user_login/data/user_login_repo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UserLoginRepoImpl extends UserLoginRepo{
  UserLoginRepoImpl();
  static const FlutterSecureStorage _storage =
      FlutterSecureStorage();

  @override
  Future<String> auth(String usr, String pwd)async{
    final url = Uri.parse('https://shaktihormannuat.easycloud.co.in/api/method/shaktihormann.api.getUsers');
    final response = await http.post(url,
     headers: {
        'Content-Type': 'application/json',
      },
    body: jsonEncode({
    'usr': usr,
    'pwd': pwd
    }));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final message = data['message']['data'];

      await _storage.write(key: 'api_key', value: message['api_key']);
      await _storage.write(key: 'api_secret', value: message['api_secret']);
      // final savedKey = await _storage.read(key: 'api_key');
      // print('Saved api_key: $savedKey');
    }
    return response.body;
}
    
     Future<String?> getApiKey() => _storage.read(key: 'api_key');
     Future<String?> getApiSecret() => _storage.read(key: 'api_secret');
     Future<void> logout() => _storage.deleteAll();


  @override
Future<List<dynamic>> getEntries() async {
  final apiKey = await _storage.read(key: 'api_key');
  final apiSecret = await _storage.read(key: 'api_secret');

  if (apiKey == null || apiSecret == null) {
    throw Exception('API credentials not found. Please log in again.');
  }

  final url = Uri.parse(
    'https://shaktihormannuat.easycloud.co.in/api/method/frappe.client.get_list',
  ).replace(queryParameters: {
    'doctype': 'Gate Entry',
    'limit_page_length': '100',
    'order_by': 'creation desc',
    'fields': ['*']
  });

  final response = await http.get(
    url,
    headers: {
      'Accept': 'application/json',
      'Authorization': 'token $apiKey:$apiSecret',
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['message'] as List<dynamic>;
  }

  throw Exception(
    'Failed to fetch Gate Entry: ${response.statusCode} ${response.body}',
  );
}
    
}