import 'package:flutter/material.dart';
import 'package:theta_chat/common/presentation/widgets/app_hbox_widget.dart';
import 'package:theta_chat/common/presentation/widgets/app_income_message.dart';
import 'package:theta_chat/common/presentation/widgets/app_outcome_message.dart';
import 'package:theta_chat/common/presentation/widgets/app_waiting_animated_dots.dart';
import 'package:theta_chat/common/presentation/widgets/keyboard_dismisser.dart';
import 'package:theta_chat/config/theme.dart';

class ChatBodyBuild extends StatelessWidget {
  const ChatBodyBuild(
    this.chatting, {
    Key? key,
  }) : super(key: key);

  final List<String> chatting;

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: chatting.length,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
              separatorBuilder: (context, _) => const HBox(20),
              itemBuilder: (context, index) {
                if (index == 6) {
                  return const AppWaitingAnimatedDots();
                } else if (index % 2 == 0 || index > 5) {
                  return AppIncomeMessage(chatting.first);
                }
                return AppOutcomeMessage(
                  chatting.last,
                  isHaveError: index == 5,
                );
              },
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
                minLines: 1,
                // Минимальное количество строк
                maxLines: 3,
                // Ограничивает количество строк максимум тремя
                keyboardType: TextInputType.multiline,
                // Включает поддержку многострочного ввода
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
          const HBox(20),
        ],
      ),
    );
  }
}
