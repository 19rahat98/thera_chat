import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_icon_button.dart';
import 'package:theta_chat/config/theme.dart';

class DynamicAppBar extends StatelessWidget {
  const DynamicAppBar(
    this.title, {
    Key? key,
    this.backgroundImage = AppImages.icBackgroundSignUp,
  }) : super(key: key);

  final String title;
  final String backgroundImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            backgroundImage,
            fit: BoxFit.fill,
          ),
          Positioned(
            top: 48,
            left: 12,
            child: AppIconButton(
              onPress: () => Navigator.pop(context),
              background: Colors.transparent,
              AppIcons.icArrowLeft,
              iconSize: 32,
              color: Colors.white,
            ),
          ),
          Positioned(
            right: 16,
            bottom: 20,
            child: Text(
              title,
              style: AppTextStyle.h1,
            ),
          ),
        ],
      ),
    );
  }
}
