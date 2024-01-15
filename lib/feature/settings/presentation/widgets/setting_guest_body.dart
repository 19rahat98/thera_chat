import 'package:flutter/material.dart';
import 'package:theta_chat/common/presentation/widgets/app_hbox_widget.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_tile_button.dart';
import 'package:theta_chat/config/theme.dart';
import 'package:theta_chat/feature/confidentiality/presentation/ui/confidentiality_screen.dart';
import 'package:theta_chat/feature/launch/presentation/ui/launch_screen.dart';

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
            'Здесь обычно хранится что-то очень важное, но сейчас это место пустует.',
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
          onTap: () {},
          icon: AppIcons.icMailFilled,
          title: 'Message Center',
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
        AppTileButton(
          onTap: () {},
          icon: AppIcons.icBellFilled,
          title: 'Notifications',
        ),
        const HBox(20),
        AppTextButton(
          onTap: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LaunchScreen()),
            ModalRoute.withName('/'),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          text: 'Войти',
          style: AppTextStyle.button3,
        ),
      ],
    );
  }
}
