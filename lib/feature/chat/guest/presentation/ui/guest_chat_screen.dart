import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theta_chat/common/presentation/widgets/app_bar/common_app_bar.dart';
import 'package:theta_chat/common/presentation/widgets/app_hbox_widget.dart';
import 'package:theta_chat/common/presentation/widgets/app_income_message.dart';
import 'package:theta_chat/common/presentation/widgets/app_outcome_message.dart';
import 'package:theta_chat/common/presentation/widgets/app_waiting_animated_dots.dart';
import 'package:theta_chat/common/presentation/widgets/app_wbox_widget.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_filled_color_button.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_icon_button.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_outline_button_widget.dart';
import 'package:theta_chat/common/presentation/widgets/keyboard_dismisser.dart';
import 'package:theta_chat/config/theme.dart';
import 'package:theta_chat/feature/launch/presentation/ui/launch_screen.dart';

class GuestChatScreen extends StatefulWidget {
  const GuestChatScreen({Key? key}) : super(key: key);

  @override
  State<GuestChatScreen> createState() => _GuestChatScreenState();
}

class _GuestChatScreenState extends State<GuestChatScreen> {
  bool _enableTextField = false;
  var chatting = [
    'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation venia consequat sunt nostrud amet.cccc',
    'Привет, меня зовут Эмма.',
    'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation venia consequat sunt nostrud amet.cccc',
    'Привет, меня зовут Эмма.',
    'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation venia consequat sunt nostrud amet.cccc',
    'Привет, меня зовут Эмма.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(height: 54),
      body: KeyboardDismisser(
        child: ListView.separated(
          itemCount: chatting.length,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
          separatorBuilder: (context, _) => const HBox(20),
          itemBuilder: (context, index) {
            if (index == 5 && !_enableTextField) {
              return const AppWaitingAnimatedDots();
            } else if (index % 2 == 0 || index > 5) {
              return AppIncomeMessage(
                chatting.first,
                enableAdditionAction: index > 5,
              );
            }
            return AppOutcomeMessage(chatting.last);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: buildFloatingActionWidget(),
    );
  }

  Widget buildFloatingActionWidget() {
    if (_enableTextField) {
      return Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.grey300),
          ),
          child: TextField(
            autofocus: true,
            style: AppTextStyle.body1,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              suffixIcon: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.grey50,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: AppIconButton(
                  AppIcons.icSendOutline,
                  onPress: () {},
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      child: Row(
        children: [
          Expanded(
            child: AppFilledColorButton(
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const LaunchScreen(),
                ),
              ),
              height: 40,
              borderRadiusRadii: 24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppIcons.icUserOutline,
                    color: Colors.white,
                  ),
                  const WBox(8),
                  const Text('Вход'),
                ],
              ),
            ),
          ),
          const WBox(20),
          Expanded(
            child: AppOutlineButtonWidget(
              onTap: () {
                _enableTextField = true;
                chatting.addAll([
                  'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation venia consequat sunt nostrud amet.cccc',
                  'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation venia consequat sunt nostrud amet.cccc',
                ]);
                setState(() {});
              },
              borderRadiusRadii: 24,
              constraints: const BoxConstraints(maxHeight: 40),
              child: Text(
                'Остаться как гость',
                style: AppTextStyle.button2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
