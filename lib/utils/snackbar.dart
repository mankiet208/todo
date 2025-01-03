import 'package:flutter/material.dart';
import 'package:todo/utils/extensions/context_extension.dart';

class AppSnackBar {
  static void showSnackBarSuccess(
    BuildContext context, {
    required String message,
  }) {
    _showSnackBar(
      context,
      message: message,
      backgroundColor: context.colorScheme.tertiary,
      textColor: context.colorScheme.onTertiary,
    );
  }

  static void showSnackBarError(
    BuildContext context, {
    required String message,
  }) {
    _showSnackBar(
      context,
      message: message,
      backgroundColor: context.colorScheme.error,
      textColor: context.colorScheme.onError,
    );
  }

  static void _showSnackBar(
    BuildContext context, {
    required String message,
    Color? backgroundColor,
    Color? textColor,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: context.textTheme.bodyMedium?.copyWith(
            color: textColor,
          ),
        ),
        backgroundColor: backgroundColor,
        action: SnackBarAction(
          label: context.appLocalizations!.general_close,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
