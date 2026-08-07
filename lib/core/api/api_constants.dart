class ApiConstants {
  // Base URL - replace with your actual API URL
  static const String baseUrl = 'https://your-api-url.com';

  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh-token';

  // Product endpoints
  static const String products = '/products';
  static const String productDetails = '/products/{id}';
  static const String categories = '/categories';

  // Cart endpoints
  static const String cart = '/cart';
  static const String addToCart = '/cart/add';
  static const String removeFromCart = '/cart/remove';

  // Order endpoints
  static const String orders = '/orders';
  static const String orderDetails = '/orders/{id}';

  // User endpoints
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/profile/update';

  // Headers
  static const String authorization = 'Authorization';
  static const String contentType = 'Content-Type';
  static const String accept = 'Accept';
  static const String applicationJson = 'application/json';
}
