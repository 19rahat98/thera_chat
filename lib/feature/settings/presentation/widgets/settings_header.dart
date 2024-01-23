import 'package:flutter/material.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_icon_button.dart';
import 'package:theta_chat/config/theme.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 185,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                AppImages.icBackgroundSettings,
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          top: 60,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppIconButton(
                onPress: () => Navigator.pop(context),
                background: Colors.transparent,
                AppIcons.icArrowLeft,
                iconSize: 24,
              ),
              Text('Setting', style: AppTextStyle.h4),
              const SizedBox(
                width: 40,
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: -50,
          child: SizedBox(
            width: 100,
            height: 100,
            child: Image.asset(AppIcons.icAssistantSquireOutline),
          ),
        ),
      ],
    );
  }
}
