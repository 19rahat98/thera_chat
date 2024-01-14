import 'package:flutter/material.dart';
import 'package:theta_chat/config/theme.dart';
import 'package:theta_chat/feature/chat/guest/presentation/ui/widgets/guest_chat_bottom_bar.dart';
import 'package:theta_chat/feature/chat/guest/presentation/ui/widgets/guest_chat_text_field.dart';
import 'package:theta_chat/feature/onboarding/presentation/controller/onboarding_riverpod.dart';

class OnboardingFooter extends StatelessWidget {
  const OnboardingFooter(
    this.state, {
    Key? key,
    required this.controller,
    required this.activateChat,
    required this.onSendMessage,
  }) : super(key: key);

  final OnboardingState state;
  final Function() activateChat;
  final Function() onSendMessage;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    if (state.isLoading && state.chat.length == 1) {
      return const SizedBox.shrink();
    } else if (state.status == OnboardingStatus.common) {
      return Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 20),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.grey300),
        ),
        child: TextField(
          readOnly: true,
          enabled: false,
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
      );
    } else if (state.status == OnboardingStatus.definitive) {
      return GuestChatBottomActionBar(activateChat: activateChat);
    } else if (state.status == OnboardingStatus.guestChat ||
        state.status == OnboardingStatus.failure) {
      return GuestChatTextField(
        onSendMessage: onSendMessage,
        controller: controller,
      );
    }

    return const SizedBox.shrink();
  }
}
