import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theta_chat/common/presentation/widgets/app_hbox_widget.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:theta_chat/config/theme.dart';
import 'package:theta_chat/feature/onboarding/presentation/ui/thera_chat_onboarding_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.5, end: 0.75).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Container(
                      clipBehavior: Clip.none,
                      width: MediaQuery.of(context).size.height * 0.75,
                      height: MediaQuery.of(context).size.height * 0.75,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          radius: _animation.value,
                          center: const Alignment(0, 0),
                          colors: [
                            const Color(0xFFAA00F3),
                            const Color(0xFFD267FF).withOpacity(0),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  clipBehavior: Clip.none,
                  width: MediaQuery.of(context).size.height * 0.75,
                  height: MediaQuery.of(context).size.height * 0.75,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      radius: .5,
                      center: const Alignment(.3, 0), // near the top right
                      colors: [
                        const Color(0xFFAA00F3).withOpacity(.5),
                        const Color(0xFFD267FF).withOpacity(0),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Hello',
                    style: AppTextStyle.h1,
                  ),
                ),
              ],
            ),
          ),
          AppTextButton(
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const TheraChatOnboardingScreen(),
              ),
            ),
            text: 'tap to contiune',
            padding: const EdgeInsets.symmetric(horizontal: 12),
          ),
          const HBox(64),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
