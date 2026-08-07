import '../../data/models/auth_response_model.dart';

abstract class AuthRepository {
  Future<AuthResponseModel> login(String email, String password);
  Future<AuthResponseModel> register(Map<String, dynamic> data);
  Future<void> logout();
  Future<bool> isLoggedIn();
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
}