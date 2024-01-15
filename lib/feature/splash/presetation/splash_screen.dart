import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theta_chat/common/presentation/widgets/app_bar/common_app_bar.dart';
import 'package:theta_chat/feature/auth/common/presentation/controller/authentication_controller.dart';
import 'package:theta_chat/feature/auth/login/presentation/ui/login_screen.dart';
import 'package:theta_chat/feature/chat/thera_chat/presentation/ui/thera_chat_screen.dart';
import 'package:theta_chat/feature/chat/thera_chat/presentation/ui/widgets/chat_radius_animation.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final state = ref.watch(authProvider);

      if (state.status == AuthenticationStatus.init) {
        return Scaffold(
          appBar: const CommonAppBar(),
          body: Align(
            alignment: const Alignment(0.0, -0.4),
            child: ChatRadiusAnimation(
              onComplete: () {},
            ),
          ),
        );
      } else if (state.user != null) {
        return const TheraChatScreen();
      }

      return const LoginScreen();
    });
  }
}
