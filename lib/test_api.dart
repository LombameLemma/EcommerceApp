import 'core/api/api_service.dart';

void testGet() async {
  final api = ApiService();

  final response = await api.get("/products");

  print(response.data);
}
