import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_constants.dart';
import 'product_model.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return ProductRepository(dio);
});

class ProductRepository {
  final Dio _dio;

  ProductRepository(this._dio);

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _dio.get(ApiConstants.products);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => ProductModel.fromJson(json)).toList();
      }
      throw Exception('Failed to load products');
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  Future<List<String>> getCategories() async {
    try {
      final response = await _dio.get(ApiConstants.categories);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((e) => e.toString()).toList();
      }
      throw Exception('Failed to load categories');
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }
}
