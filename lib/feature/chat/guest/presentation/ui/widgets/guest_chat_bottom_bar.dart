import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theta_chat/common/presentation/widgets/app_wbox_widget.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_filled_color_button.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_outline_button_widget.dart';
import 'package:theta_chat/config/theme.dart';
import 'package:theta_chat/feature/launch/presentation/ui/launch_screen.dart';

class GuestChatBottomActionBar extends StatelessWidget {
  const GuestChatBottomActionBar({
    Key? key,
    required this.activateChat,
  }) : super(key: key);

  final Function() activateChat;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.grey50,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
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
                  Text(
                    'Вход',
                    style: AppTextStyle.button2.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const WBox(20),
          Expanded(
            child: AppOutlineButtonWidget(
              onTap: activateChat,
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
