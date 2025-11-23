import 'package:ecommerce/config/app_routes.dart';
import 'package:ecommerce/views/auth/auth_screen.dart';
import 'package:ecommerce/views/home/home_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter routerConfigInit() {
  final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    redirect: (context, state) {
      return AppRoutes.auth;
    },
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.auth,
        name: AppRoutes.auth,
        builder: (context, state) => const AuthScreen(),
      ),
    ],
  );
  return router;
}
