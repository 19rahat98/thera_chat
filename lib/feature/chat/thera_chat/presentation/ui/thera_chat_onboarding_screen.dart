import 'package:flutter/material.dart';
import 'package:theta_chat/common/presentation/widgets/app_bar/common_app_bar.dart';
import 'package:theta_chat/config/theme.dart';
import 'package:theta_chat/feature/chat/thera_chat/presentation/ui/thera_chat_screen.dart';
import 'package:theta_chat/feature/chat/thera_chat/presentation/ui/widgets/chat_radius_animation.dart';
import 'package:theta_chat/feature/chat/thera_chat/presentation/ui/widgets/example_chat_variants_widget.dart';

class TheraChatOnboardingScreen extends StatefulWidget {
  const TheraChatOnboardingScreen({super.key});

  @override
  State<TheraChatOnboardingScreen> createState() => _TheraChatOnboardingScreenState();
}

class _TheraChatOnboardingScreenState extends State<TheraChatOnboardingScreen> {
  bool _isTutorialEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey20,
      appBar: CommonAppBar(
        onPressLeading: () => Navigator.pop(context),
        leadingSize: 30,
        leadingIcon: AppIcons.icCross,
      ),
      body: Column(
        children: [
          Expanded(
            child: Visibility(
              visible: _isTutorialEnable,
              replacement: ChatRadiusAnimation(
                onComplete: () => setState(() {
                  _isTutorialEnable = true;
                }),
              ),
              child: const ExampleChatVariantsWidget(),
            ),
          ),
          Container(
            color: AppColors.grey20,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.grey300),
              ),
              child: TextField(
                readOnly: true,
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TheraChatScreen(),
                  ),
                ),
                enabled: _isTutorialEnable,
                style: AppTextStyle.body1,
                decoration: const InputDecoration(
                  hintText: 'Textfield',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
