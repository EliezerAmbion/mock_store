import 'package:go_router/go_router.dart';
import 'package:mock_store/presentation/screens/home.screen.dart';
import 'package:mock_store/presentation/screens/product_detail/product_detail.screen.dart';

class Routes {
  static const String home = '/';
  static const String productDetails = '/products/:id';
}

GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: Routes.productDetails,
          builder: (context, state) {
            final String? idParam = state.pathParameters['id'];
            final int id = int.parse(idParam!);

            return ProductDetailScreen(id: id);
          },
        ),
      ],
    ),
  ],
);
