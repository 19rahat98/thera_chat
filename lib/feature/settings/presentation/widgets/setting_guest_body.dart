import 'package:flutter/material.dart';
import 'package:theta_chat/common/presentation/widgets/app_hbox_widget.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_tile_button.dart';
import 'package:theta_chat/config/theme.dart';
import 'package:theta_chat/feature/auth/login/presentation/ui/login_screen.dart';
import 'package:theta_chat/feature/confidentiality/presentation/ui/confidentiality_screen.dart';

class SettingGuestBody extends StatelessWidget {
  const SettingGuestBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HBox(60),
        Text(
          'Guest',
          style: AppTextStyle.h4,
        ),
        const HBox(4),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 48),
          child: Text(
            'Something important is usually stored here, but now this place is empty.',
            textAlign: TextAlign.center,
            style: AppTextStyle.body2,
          ),
        ),
        const HBox(28),
        const AppTileButton(
          enable: false,
          icon: AppIcons.icUserFilled,
          title: 'Personal Information',
        ),
        AppTileButton(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ConfidentialityScreen(),
            ),
          ),
          icon: AppIcons.icInformationFilled,
          title: 'Confidentiality',
        ),
        const HBox(20),
        AppTextButton(
          onTap: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const LoginScreen(),
            ),
            ModalRoute.withName('/'),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          text: 'Log in',
          style: AppTextStyle.button3,
        ),
      ],
    );
  }
}
