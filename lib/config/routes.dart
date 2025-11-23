import 'package:ecommerce/config/app_routes.dart';
import 'package:ecommerce/views/auth/auth_screen.dart';
import 'package:ecommerce/views/auth/register_screen.dart';
import 'package:ecommerce/views/home/home_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter routerConfigInit() {
  final GoRouter router = GoRouter(
    initialLocation: AppRoutes.register,
    redirect: (context, state) {
      // final List<String> publicRoutes = [AppRoutes.auth, AppRoutes.home];
      // final isAuthenticated = false;
      // final isPublicRoutes = publicRoutes.contains(state.uri.toString());
      // print(isPublicRoutes);
      // if (isAuthenticated) {
      //   return AppRoutes.home;
      // }
      // if (!isAuthenticated && state.uri.toString() == AppRoutes.home) {
      //   return AppRoutes.auth;
      // }
      return state.fullPath;
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
      GoRoute(
        path: AppRoutes.register,
        name: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
    ],
  );
  return router;
}
