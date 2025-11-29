import 'package:flutter/material.dart';

enum ToastType { success, error }

class ToastContent extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String message;
  final Color textColor;
  final FontWeight fontWeight;

  const ToastContent({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.message,
    this.textColor = Colors.white,
    this.fontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: iconColor, size: 24),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            message,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: textColor,
              fontWeight: fontWeight,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class Toast {
  static void show({
    required BuildContext context,
    required String message,
    required ToastType type,
    Duration duration = const Duration(seconds: 3),
  }) {
    Widget toastWidget;
    switch (type) {
      case ToastType.success:
        toastWidget = ToastContent(
          message: message,
          icon: Icons.check_circle_rounded,
          iconColor: Colors.green,
        );
        break;
      case ToastType.error:
        toastWidget = ToastContent(
          message: message,
          icon: Icons.error,
          iconColor: Theme.of(context).colorScheme.error,
        );
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: toastWidget,
        duration: duration,
        backgroundColor: Colors.black87,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
