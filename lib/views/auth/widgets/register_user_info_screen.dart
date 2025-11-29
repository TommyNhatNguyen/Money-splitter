import 'package:ecommerce/blocs/auth/auth_bloc.dart';
import 'package:ecommerce/blocs/auth/auth_state.dart';
import 'package:ecommerce/core/blocs/base_state.dart';
import 'package:ecommerce/data/models/payloads/auth_register_payload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterUserInfoScreen extends StatefulWidget {
  const RegisterUserInfoScreen({super.key, required this.payload});

  final AuthRegisterPayload payload;

  @override
  _RegisterUserInfoScreenState createState() => _RegisterUserInfoScreenState();
}

class _RegisterUserInfoScreenState extends State<RegisterUserInfoScreen> {
  final formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  void onSubmit(BuildContext context) {
    
    // authBloc.add(AuthRegistrationPressed(payload: payload));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        final isAuthenticated =
            state.requestStatus == RequestStatus.completed &&
            state.isAuthenticated;
        if (isAuthenticated) {
          // context.push(AppRoutes.registerUserInfo);
          // Toast.show(
          //   context: context,
          //   message: "Register successfully",
          //   type: ToastType.success,
          // );
        }
      },
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
                    decoration: InputDecoration(hintText: "Enter phone number"),
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
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: FilledButton(
                      onPressed: () => isLoading ? null : onSubmit(context),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text("Done"),
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
