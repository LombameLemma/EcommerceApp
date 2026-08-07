import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://fakestoreapi.com",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  // =========================
  // GET Request
  // =========================
  Future<Response> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response;
    } catch (e) {
      throw Exception("GET Error: $e");
    }
  }

  // =========================
  // POST Request
  // =========================
  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(endpoint, data: data);

      return response;
    } catch (e) {
      throw Exception("POST Error: $e");
    }
  }

  // =========================
  // PUT Request
  // =========================
  Future<Response> put(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(endpoint, data: data);

      return response;
    } catch (e) {
      throw Exception("PUT Error: $e");
    }
  }

  // =========================
  // DELETE Request
  // =========================
  Future<Response> delete(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);

      return response;
    } catch (e) {
      throw Exception("DELETE Error: $e");
    }
  }
}
