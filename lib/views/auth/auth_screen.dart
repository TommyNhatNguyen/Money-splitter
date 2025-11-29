import 'package:ecommerce/config/app_routes.dart';
import 'package:ecommerce/core/assets/app_images.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset(AppImages.background, fit: BoxFit.cover),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(AppImages.logo, fit: BoxFit.contain, width: 96),
              const SizedBox(height: 48),
              SizedBox(
                width: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          context.push(AppRoutes.register);
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context.push(AppRoutes.login);
                        },
                        child: const Text(
                          "Log in",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                spacing: 4,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Terms",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const Text("|"),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Privacy Policy",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const Text("|"),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Contact us",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
