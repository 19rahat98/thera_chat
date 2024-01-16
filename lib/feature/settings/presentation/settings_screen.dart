import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theta_chat/feature/auth/common/presentation/controller/authentication_controller.dart';
import 'package:theta_chat/feature/settings/presentation/widgets/setting_guest_body.dart';
import 'package:theta_chat/feature/settings/presentation/widgets/setting_user_body.dart';
import 'package:theta_chat/feature/settings/presentation/widgets/settings_header.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.read(authProvider.notifier);
    final state = ref.watch(authProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SettingsHeader(),
            if (state.status == AuthenticationStatus.authenticated)
              SettingUserBody(
                state.user!,
                logOut: authController.onSignOut,
              ),
            if (state.status == AuthenticationStatus.unauthenticated) const SettingGuestBody(),
          ],
        ),
      ),
    );
  }
}
