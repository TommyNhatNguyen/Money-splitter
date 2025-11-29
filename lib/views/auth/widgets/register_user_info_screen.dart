import 'package:ecommerce/blocs/user/user_bloc.dart';
import 'package:ecommerce/blocs/user/user_event.dart';
import 'package:ecommerce/blocs/user/user_state.dart';
import 'package:ecommerce/config/app_routes.dart';
import 'package:ecommerce/core/blocs/base_state.dart';
import 'package:ecommerce/core/widgets/base_button.dart';
import 'package:ecommerce/core/widgets/toast.dart';
import 'package:ecommerce/data/models/payloads/auth_register_payload.dart';
import 'package:ecommerce/data/models/payloads/user_create_payload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterUserInfoScreen extends StatefulWidget {
  const RegisterUserInfoScreen({super.key, required this.authPayload});
  final AuthRegisterPayload authPayload;

  @override
  _RegisterUserInfoScreenState createState() => _RegisterUserInfoScreenState();
}

class _RegisterUserInfoScreenState extends State<RegisterUserInfoScreen> {
  final formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  void onSubmit(BuildContext context) {
    if (!formKey.currentState!.validate()) {
      return;
    }
    final userBloc = context.read<UserBloc>();
    UserCreatePayload payload = UserCreatePayload(
      username: _fullNameController.text,
      usernameNormalized: _fullNameController.text.trim().toLowerCase(),
      phone: _phoneNumberController.text,
      authPayload: widget.authPayload,
    );
    userBloc.add(UserCreatedPressed(payload: payload));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state.requestStatus == RequestStatus.completed) {
              Toast.show(
                context: context,
                message: "User created successfully!",
                type: ToastType.success,
              );
              context.replaceNamed(AppRoutes.home);
            } else if (state.requestStatus == RequestStatus.error) {
              Toast.show(
                context: context,
                message: 'Error: ${state.error ?? "Unknown error"}',
                type: ToastType.error,
              );
              context.pop();
            }
          },
        ),
      ],
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          final isLoading = state.requestStatus == RequestStatus.loading;
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
                      controller: _fullNameController,
                      decoration: InputDecoration(
                        labelText: "Full name",
                        hintText: "Enter full name",
                      ),
                      validator: (value) {
                        final isNotValid = value == null || value.isEmpty;
                        if (isNotValid) {
                          return "Full name can't be null";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                        hintText: "Enter phone number",
                      ),
                      validator: (value) {
                        final isNotValid = value == null || value.isEmpty;
                        if (isNotValid) {
                          return "Please enter a valid phone number";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 24),
                    LoadingFilledButton(
                      isLoading: isLoading,
                      child: Text("Done"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
