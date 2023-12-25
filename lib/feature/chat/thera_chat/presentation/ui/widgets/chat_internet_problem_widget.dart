import 'package:flutter/material.dart';
import 'package:theta_chat/common/presentation/widgets/app_internet_problem_widget.dart';
import 'package:theta_chat/common/presentation/widgets/keyboard_dismisser.dart';
import 'package:theta_chat/config/theme.dart';

class ChatInternetProblemWidget extends StatelessWidget {
  const ChatInternetProblemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const AppInternetProblemWidget(),
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
          ],
        ),
      ),
    );
  }
}
