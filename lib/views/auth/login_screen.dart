import 'package:ecommerce/blocs/auth/auth_bloc.dart';
import 'package:ecommerce/blocs/auth/auth_event.dart';
import 'package:ecommerce/blocs/auth/auth_state.dart';
import 'package:ecommerce/config/app_routes.dart';
import 'package:ecommerce/core/blocs/base_state.dart';
import 'package:ecommerce/core/widgets/base_button.dart';
import 'package:ecommerce/core/widgets/toast.dart';
import 'package:ecommerce/data/models/payloads/auth_login_payload.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  AuthBloc get authBloc => AuthBloc();
  bool isShowPassword = false;

  void toggleShowPassword() {
    setState(() {
      isShowPassword = !isShowPassword;
    });
  }

  void onSubmit(BuildContext context) {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    } else {
      final AuthLoginPayload payload = AuthLoginPayload(
        email: _emailController.text,
        password: _passwordController.text,
      );
      authBloc.add(AuthLoginPressed(payload: payload));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isAuthenticated) {
          Toast.show(
            context: context,
            message: "Welcome to Spliter!",
            type: ToastType.success,
          );
          context.replaceNamed(AppRoutes.home);
        } else {
          Toast.show(
            context: context,
            message: 'Error: ${state.error ?? "Unknown error"}',
            type: ToastType.error,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.requestStatus == RequestStatus.loading;
        return Scaffold(
          appBar: AppBar(title: Text("Sign in"), centerTitle: false),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  TextFormField(
                    autofocus: true,
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Email address",
                      hintText: "Enter email",
                    ),
                    validator: (value) {
                      final isNotValid =
                          value == null ||
                          value.isEmpty ||
                          !EmailValidator.validate(value);
                      if (isNotValid) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    obscureText: !isShowPassword,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Enter password",
                      suffixIcon: IconButton(
                        onPressed: toggleShowPassword,
                        icon: isShowPassword
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                    ),
                    validator: (value) {
                      final isNotValid = value == null || value.isEmpty;
                      if (isNotValid) {
                        return "Please enter a valid password";
                      } else if (value.length <= 6) {
                        return "Password must have more than 6 characters";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  LoadingFilledButton(
                    isLoading: isLoading,
                    child: const Text("Login"),
                    onPressed: () => onSubmit(context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
