import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_constants.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepository(dio);
});

class AuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);

  Future<String> login(String username, String password) async {
    try {
      final response = await _dio.post(
        ApiConstants.login,
        data: {
          'username': username,
          'password': password,
        },
      );
      
      if (response.statusCode == 200 && response.data != null) {
        return response.data['token'] as String;
      } else {
        throw Exception('Failed to login. Please check your credentials.');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Invalid username or password.');
      }
      throw Exception(e.message ?? 'An error occurred during login.');
    }
  }
}
