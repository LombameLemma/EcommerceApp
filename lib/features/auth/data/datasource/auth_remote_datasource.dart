import 'package:dio/dio.dart';

import '../../../../core/network/dio_client.dart';

class AuthRemoteDataSource {
  Future<String> login(
    String username,
    String password,
  ) async {
    final response = await DioClient.dio.post(
      '/auth/login',
      data: {
        "username": username,
        "password": password,
      },
    );

    return response.data["token"];
  }
}