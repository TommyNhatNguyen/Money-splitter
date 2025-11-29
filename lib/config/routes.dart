import 'package:ecommerce/blocs/auth/auth_bloc.dart';
import 'package:ecommerce/blocs/user/user_bloc.dart';
import 'package:ecommerce/config/app_routes.dart';
import 'package:ecommerce/data/models/payloads/auth_register_payload.dart';
import 'package:ecommerce/views/auth/auth_screen.dart';
import 'package:ecommerce/views/auth/register_screen.dart';
import 'package:ecommerce/views/auth/widgets/register_user_info_screen.dart';
import 'package:ecommerce/views/home/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

GoRouter routerConfigInit() {
  final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    redirect: (context, state) {
      AuthBloc authBloc = context.read<AuthBloc>();
      final isAuthenticated = authBloc.state.isAuthenticated;
      if (isAuthenticated) {
        return AppRoutes.home;
      }
      if (!isAuthenticated && state.uri.toString() == AppRoutes.home) {
        return AppRoutes.auth;
      }
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
        routes: [
          GoRoute(
            path: AppRoutes.registerUserInfo,
            name: AppRoutes.registerUserInfo,
            builder: (context, state) {
              final AuthRegisterPayload payload =
                  state.extra as AuthRegisterPayload;
              return BlocProvider(
                create: (context) => UserBloc(),
                child: RegisterUserInfoScreen(authPayload: payload),
              );
            },
          ),
        ],
      ),
    ],
  );
  return router;
}
