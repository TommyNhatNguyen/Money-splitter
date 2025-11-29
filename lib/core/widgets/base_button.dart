import 'package:flutter/material.dart';

class LoadingFilledButton extends StatelessWidget {
  final bool isLoading;
  final void Function()? onPressed;
  final Widget child;

  const LoadingFilledButton({
    super.key,
    this.isLoading = false,
    this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : child,
      ),
    );
  }
}
