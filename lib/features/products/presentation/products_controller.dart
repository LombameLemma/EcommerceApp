import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/product_model.dart';
import '../data/product_repository.dart';

// Provider that fetches all products
final productsFutureProvider = FutureProvider<List<ProductModel>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getProducts();
});

// Provider for categories
final categoriesFutureProvider = FutureProvider<List<String>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getCategories();
});
