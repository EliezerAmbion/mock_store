import 'package:go_router/go_router.dart';
import 'package:mock_store/presentation/screens/home/home.screen.dart';

class Routes {
  static const String home = '/';
  static const String productDetails = '/products/:id';
}

GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
