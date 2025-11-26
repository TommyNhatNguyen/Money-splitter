import 'package:ecommerce/blocs/auth/auth_bloc.dart';
import 'package:ecommerce/blocs/auth/auth_event.dart';
import 'package:ecommerce/blocs/auth/auth_state.dart';
import 'package:ecommerce/core/blocs/base_state.dart';
import 'package:ecommerce/data/models/payloads/auth_register_payload.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isShowPassword = false;

  void toggleShowPassword() {
    setState(() {
      isShowPassword = !isShowPassword;
    });
  }

  void onSubmit(BuildContext context) {
    AuthBloc authBloc = context.read<AuthBloc>();
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    } else {
      final AuthRegisterPayload payload = AuthRegisterPayload(
        email: _emailController.text,
        password: _passwordController.text,
      );
      authBloc.add(AuthRegistrationPressed(payload: payload));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        print(state);
        final isAuthenticated =
            state.requestStatus == RequestStatus.completed &&
            state.isAuthenticated;
        if (isAuthenticated) {
          print(state.user);
        }
      },
      builder: (context, state) {
        if (state.requestStatus == RequestStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.isAuthenticated) {
          return Placeholder();
        }
        return Scaffold(
          appBar: AppBar(title: Text("Sign up"), centerTitle: false),
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
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => onSubmit(context),
                      child: Text("Next"),
                    ),
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
