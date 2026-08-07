import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import '../../../../core/providers/providers.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../data/models/auth_response_model.dart';
import '../../domain/repositories/auth_repository_impl.dart';
import '../../../../core/api/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Auth State
class AuthState {
  final AuthResponseModel? userData;
  final bool isLoading;
  final String? error;
  final bool isAuthenticated;

  const AuthState({
    this.userData,
    this.isLoading = false,
    this.error,
    this.isAuthenticated = false,
  });

  AuthState copyWith({
    AuthResponseModel? userData,
    bool? isLoading,
    String? error,
    bool? isAuthenticated,
  }) {
    return AuthState(
      userData: userData ?? this.userData,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}

// Auth Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(const AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final userData = await _authRepository.login(email, password);
      state = state.copyWith(
        userData: userData,
        isAuthenticated: true,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> register(Map<String, dynamic> data) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final userData = await _authRepository.register(data);
      state = state.copyWith(
        userData: userData,
        isAuthenticated: true,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);

    try {
      await _authRepository.logout();
      state = const AuthState();
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> checkAuthStatus() async {
    final isLoggedIn = await _authRepository.isLoggedIn();
    if (isLoggedIn) {
      // TODO: Get user data from API
      // state = state.copyWith(isAuthenticated: true);
    }
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    apiService: ApiService(),
    storage: const FlutterSecureStorage(),
  );
});

// Auth Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return AuthNotifier(repository);
});
