import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theta_chat/common/presentation/widgets/app_hbox_widget.dart';
import 'package:theta_chat/common/presentation/widgets/app_wbox_widget.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_filled_color_button.dart';
import 'package:theta_chat/config/theme.dart';
import 'package:theta_chat/feature/auth/login/presentation/ui/login_screen.dart';
import 'package:theta_chat/feature/auth/sign_up/presentation/ui/sign_up_screen.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  Timer? _timer;
  int _currentIndex = 0;

  final backgroundImages = [
    AppImages.icMeditationBackground1,
    AppImages.icMeditationBackground2,
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer t) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % backgroundImages.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedSwitcher(
            layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
              return Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: <Widget>[
                  ...previousChildren,
                  if (currentChild != null) currentChild,
                ],
              );
            },
            duration: const Duration(seconds: 5),
            child: Image.asset(
              backgroundImages[_currentIndex],
              key: ValueKey<int>(_currentIndex),
              fit: BoxFit.fill,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: SvgPicture.asset(
                  AppIcons.icLaunchIcon,
                ),
              ),
              AppFilledColorButton(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                ),
                borderRadiusRadii: 30,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'У меня есть аккаунт',
                  style: AppTextStyle.button1.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              AppFilledColorButton(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SignUpScreen(),
                  ),
                ),
                color: Colors.white,
                borderRadiusRadii: 30,
                padding: const EdgeInsets.symmetric(vertical: 12),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Регистрация',
                  style: AppTextStyle.button1,
                ),
              ),
              const HBox(40),
              AppFilledColorButton(
                onTap: () {},
                color: Colors.white,
                borderRadiusRadii: 30,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(AppIcons.icGoogleFilled),
                    const WBox(8),
                    Text(
                      'Вход через Gmail',
                      style: AppTextStyle.button1,
                    ),
                  ],
                ),
              ),
              AppFilledColorButton(
                onTap: () {},
                color: Colors.white,
                borderRadiusRadii: 30,
                padding: const EdgeInsets.symmetric(vertical: 12),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(AppIcons.icAppleFilled),
                    const WBox(8),
                    Text(
                      'Вход через Apple',
                      style: AppTextStyle.button1,
                    ),
                  ],
                ),
              ),
              const HBox(100),
            ],
          ),
        ],
      ),
    );
  }
}
