import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'api_constants.dart';

class DioClient {
  static Dio? _instance;

  static Dio get instance {
    _instance ??= _createDio();
    return _instance!;
  }

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          ApiConstants.contentType: ApiConstants.applicationJson,
          ApiConstants.accept: ApiConstants.applicationJson,
        },
      ),
    );

    dio.interceptors.addAll([
      _addLogInterceptor(),
      _addTokenInterceptor(),
      _addErrorInterceptor(),
    ]);

    return dio;
  }

  static Interceptor _addLogInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        if (kDebugMode) {
          print('🚀 Request: ${options.method} ${options.path}');
          print('📦 Headers: ${options.headers}');
          print('📨 Body: ${options.data}');
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        if (kDebugMode) {
          print(
            '✅ Response: ${response.statusCode} ${response.requestOptions.path}',
          );
          print('📦 Data: ${response.data}');
        }
        return handler.next(response);
      },
      onError: (error, handler) {
        if (kDebugMode) {
          print('❌ Error: ${error.message}');
          print('📦 Response: ${error.response?.data}');
        }
        return handler.next(error);
      },
    );
  }

  static Interceptor _addTokenInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        // TODO: Get token from storage
        // final token = await getToken();
        // if (token != null) {
        //   options.headers[ApiConstants.authorization] = 'Bearer $token';
        // }
        return handler.next(options);
      },
    );
  }

  static Interceptor _addErrorInterceptor() {
    return InterceptorsWrapper(
      onError: (error, handler) {
        if (error.response?.statusCode == 401) {
          // TODO: Handle token refresh or logout
          print('🔑 Unauthorized - Token expired');
        }
        return handler.next(error);
      },
    );
  }
}
