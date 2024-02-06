import 'package:flutter/material.dart';
import 'package:theta_chat/common/presentation/widgets/app_hbox_widget.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_tile_button.dart';
import 'package:theta_chat/config/theme.dart';
import 'package:theta_chat/feature/auth/common/domain/entity/user_detail_entity.dart';
import 'package:theta_chat/feature/auth/login/presentation/ui/login_screen.dart';
import 'package:theta_chat/feature/auth/update_user_data/presentation/ui/update_user_data_screen.dart';
import 'package:theta_chat/feature/confidentiality/presentation/ui/confidentiality_screen.dart';

class SettingUserBody extends StatelessWidget {
  const SettingUserBody(
    this.user, {
    Key? key,
    required this.logOut,
  }) : super(key: key);

  final Function() logOut;
  final UserDetailEntity user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HBox(60),
        Text(
          user.fillName,
          style: AppTextStyle.h4,
        ),
        const HBox(4),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 48),
          child: Text(
            user.email,
            textAlign: TextAlign.center,
            style: AppTextStyle.body2,
          ),
        ),
        const HBox(28),
        AppTileButton(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => UpdateUserDataScreen(user),
            ),
          ),
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
          onTap: () {
            logOut.call();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const LoginScreen(),
              ),
              ModalRoute.withName('/'),
            );
          },
          padding: const EdgeInsets.symmetric(horizontal: 12),
          text: 'Log out',
          style: AppTextStyle.button3,
        ),
      ],
    );
  }
}
