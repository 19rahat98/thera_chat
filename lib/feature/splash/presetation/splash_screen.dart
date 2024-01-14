import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theta_chat/feature/auth/common/presentation/controller/authentication_controller.dart';
import 'package:theta_chat/feature/launch/presentation/ui/launch_screen.dart';
import 'package:theta_chat/feature/nav_bar/presentation/ui/main_navigation_bar.dart';
import 'package:theta_chat/feature/onboarding/presentation/ui/onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final state = ref.watch(authProvider);

      if (state.status == AuthenticationStatus.init) {
        return const OnboardingScreen();
      } else if (state.user != null) {
        return const MainNavigationBar();
      }

      return const LaunchScreen();
    });
  }
}
