import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theta_chat/config/theme.dart';

/// СнэкБар бля успешних сценари
void showSuccessSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: CupertinoColors.activeGreen,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      duration: const Duration(milliseconds: 2200),
    ),
  );
  return;
}

/// СнэкБар для ошибок
void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: AppColors.error500,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      duration: const Duration(milliseconds: 2200),
    ),
  );
  return;
}
