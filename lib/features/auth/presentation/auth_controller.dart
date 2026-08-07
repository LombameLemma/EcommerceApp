import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../data/auth_repository.dart';

// Provider for Secure Storage
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

// Auth State Class
class AuthState {
  final bool isLoading;
  final String? token;
  final String? error;

  AuthState({
    this.isLoading = false,
    this.token,
    this.error,
  });

  bool get isAuthenticated => token != null;

  AuthState copyWith({
    bool? isLoading,
    String? token,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      token: token ?? this.token,
      error: error, // intentionally can be set to null to clear errors
    );
  }
}

// StateNotifier to manage Auth State
class AuthController extends StateNotifier<AuthState> {
  final AuthRepository _repository;
  final FlutterSecureStorage _storage;

  AuthController(this._repository, this._storage) : super(AuthState()) {
    _loadToken();
  }

  Future<void> _loadToken() async {
    state = state.copyWith(isLoading: true);
    final token = await _storage.read(key: 'jwt_token');
    if (token != null) {
      state = state.copyWith(isLoading: false, token: token);
    } else {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<bool> login(String username, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final token = await _repository.login(username, password);
      await _storage.write(key: 'jwt_token', value: token);
      state = state.copyWith(isLoading: false, token: token);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString().replaceAll('Exception: ', ''));
      return false;
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'jwt_token');
    state = AuthState(); // Reset state
  }
}

// Provider for AuthController
final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);
  return AuthController(repository, storage);
});
