import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/api/api_service.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/auth_response_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiService _apiService;
  final FlutterSecureStorage _storage;

  AuthRepositoryImpl({
    required ApiService apiService,
    required FlutterSecureStorage storage,
  }) : _apiService = apiService,
       _storage = storage;

  @override
  Future<AuthResponseModel> login(String email, String password) async {
    try {
      final response = await _apiService.login(email, password);
      final authData = AuthResponseModel.fromJson(response.data);

      // Save tokens
      await _saveTokens(authData.accessToken, authData.refreshToken);

      return authData;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<AuthResponseModel> register(Map<String, dynamic> data) async {
    try {
      final response = await _apiService.register(data);
      final authData = AuthResponseModel.fromJson(response.data);

      // Save tokens
      await _saveTokens(authData.accessToken, authData.refreshToken);

      return authData;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _apiService.logout();
    } finally {
      // Always clear tokens even if logout API fails
      await _storage.deleteAll();
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'access_token');
    return token != null && token.isNotEmpty;
  }

  @override
  Future<void> saveToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
  }

  @override
  Future<String?> getToken() async {
    return await _storage.read(key: 'access_token');
  }

  @override
  Future<void> clearToken() async {
    await _storage.deleteAll();
  }

  Future<void> _saveTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: 'access_token', value: accessToken);
    await _storage.write(key: 'refresh_token', value: refreshToken);
  }
}
