import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:theta_chat/feature/auth/common/presentation/controller/authentication_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.read(authProvider.notifier);
    return Scaffold(
      body: Center(
        child: AppTextButton(
          onTap: authController.onSignOut,
          text: 'Log Out',
        ),
      ),
    );
  }
}
