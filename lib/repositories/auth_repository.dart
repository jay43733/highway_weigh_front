import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:highway_weight/models/users_model.dart';
import 'package:highway_weight/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService = AuthService();
  final storage = FlutterSecureStorage();

  Future<UsersModel> login(String email, String password) async {
    final result = await _authService.login(email, password);
    if (result.containsKey('response') &&
        result['response'] is Map<String, dynamic>) {
      final response = result['response'];
      if (response.containsKey('token')) {
        final token = response['token'];
        final payload = response['payload'];
        await storage.write(key: 'accessToken', value: token);
        await storage.write(key: 'role', value: payload['role'].toString());
        await storage.write(key: 'name', value: payload['name']);
        await storage.write(key: 'userId', value: payload['id'].toString());
      }

      if (response.containsKey('payload')) {
        final payload = response['payload'];
        return UsersModel.fromJson(payload);
      } else {
        throw Exception('There is no payload key');
      }
    } else {
      throw Exception("result doesn't contain response key");
    }
  }
}
