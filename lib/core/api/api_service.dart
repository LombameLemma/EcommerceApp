import 'package:dio/dio.dart';
import 'dio_client.dart';
import 'api_constants.dart';

class ApiService {
  final Dio _dio = DioClient.instance;

  // Auth APIs
  Future<Response> login(String email, String password) async {
    return await _dio.post(
      ApiConstants.login,
      data: {'email': email, 'password': password},
    );
  }

  Future<Response> register(Map<String, dynamic> data) async {
    return await _dio.post(ApiConstants.register, data: data);
  }

  Future<Response> logout() async {
    return await _dio.post(ApiConstants.logout);
  }

  // Product APIs
  Future<Response> getProducts({int page = 1, int limit = 10}) async {
    return await _dio.get(
      ApiConstants.products,
      queryParameters: {'page': page, 'limit': limit},
    );
  }

  Future<Response> getProductDetails(String id) async {
    return await _dio.get(ApiConstants.productDetails.replaceAll('{id}', id));
  }

  Future<Response> getCategories() async {
    return await _dio.get(ApiConstants.categories);
  }

  // Cart APIs
  Future<Response> getCart() async {
    return await _dio.get(ApiConstants.cart);
  }

  Future<Response> addToCart(Map<String, dynamic> data) async {
    return await _dio.post(ApiConstants.addToCart, data: data);
  }

  Future<Response> removeFromCart(String id) async {
    return await _dio.delete(
      ApiConstants.removeFromCart.replaceAll('{id}', id),
    );
  }

  // Order APIs
  Future<Response> getOrders() async {
    return await _dio.get(ApiConstants.orders);
  }

  Future<Response> createOrder(Map<String, dynamic> data) async {
    return await _dio.post(ApiConstants.orders, data: data);
  }

  // User APIs
  Future<Response> getProfile() async {
    return await _dio.get(ApiConstants.profile);
  }

  Future<Response> updateProfile(Map<String, dynamic> data) async {
    return await _dio.put(ApiConstants.updateProfile, data: data);
  }
}
