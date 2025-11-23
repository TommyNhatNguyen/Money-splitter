import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    void toggleShowPassword() {
      setState(() {
        isShowPassword = !isShowPassword;
      });
    }

    void onSubmit() {
      final isValid = formKey.currentState?.validate() ?? false;
      if (!isValid) {
        return;
      } else {
        print("Email: " + _emailController.text);
        print("Password: " + _passwordController.text);
      }
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
                child: FilledButton(onPressed: onSubmit, child: Text("Next")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
