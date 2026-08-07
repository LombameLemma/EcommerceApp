import 'package:go_router/go_router.dart';


// We will add imports for these screens as we build them.
// For now, creating placeholder widgets.
import '../../features/products/presentation/home_screen.dart';
import '../../features/auth/presentation/login_screen.dart';

final appRouterProvider = goRouter();

GoRouter goRouter() {
  return GoRouter(
    initialLocation: '/', // Start at home, auth check will redirect if needed
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
    ],
  );
}
