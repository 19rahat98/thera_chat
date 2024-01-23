import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theta_chat/common/presentation/widgets/app_hbox_widget.dart';
import 'package:theta_chat/common/presentation/widgets/app_wbox_widget.dart';
import 'package:theta_chat/config/theme.dart';
import 'package:theta_chat/feature/auth/sign_up/domain/entity/validation_password_entity.dart';

class PasswordValidationErrors extends StatelessWidget {
  const PasswordValidationErrors(this.validationPassword, {Key? key}) : super(key: key);

  final ValidationPasswordEntity? validationPassword;

  @override
  Widget build(BuildContext context) {
    if (validationPassword?.strength == null ||
        validationPassword?.strength == PasswordStrength.less) {
      return const SizedBox.shrink();
    } else if (validationPassword?.strength == PasswordStrength.strong) {
      return Row(
        children: [
          Transform.rotate(
            angle: 3.1456,
            child: SvgPicture.asset(
              AppIcons.icInformationFilled,
              color: AppColors.success500,
            ),
          ),
          const WBox(8),
          Flexible(
            child: Text(
              'Password strength: weak',
              style: AppTextStyle.caption1,
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(AppIcons.icInformationFilled),
            const WBox(8),
            Flexible(
              child: Text(
                'Password strength: weak',
                style: AppTextStyle.caption1,
              ),
            ),
          ],
        ),
        const HBox(4),
        Visibility(
          visible: validationPassword?.isEnableLength == true,
          replacement: Row(
            children: [
              SvgPicture.asset(
                AppIcons.icCross,
                color: AppColors.error500,
                width: 26,
              ),
              const WBox(8),
              Text(
                'Must be at least 8 characters',
                style: AppTextStyle.caption1,
              ),
            ],
          ),
          child: Row(
            children: [
              SvgPicture.asset(AppIcons.icCheckRounded),
              const WBox(8),
              Text(
                'Must be at least 8 characters',
                style: AppTextStyle.caption1,
              ),
            ],
          ),
        ),
        const HBox(4),
        Visibility(
          visible: validationPassword?.isIncludeName == true,
          replacement: Row(
            children: [
              SvgPicture.asset(AppIcons.icCheckRounded),
              const WBox(8),
              Text(
                'Can not include your name or eamil address',
                style: AppTextStyle.caption1,
              ),
            ],
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                AppIcons.icCross,
                color: AppColors.error500,
                width: 26,
              ),
              const WBox(8),
              Text(
                'Can not include your name or eamil address',
                style: AppTextStyle.caption1,
              ),
            ],
          ),
        ),
        const HBox(4),
        Visibility(
          visible: validationPassword?.isHaveSymbol == true,
          replacement: Row(
            children: [
              SvgPicture.asset(
                AppIcons.icCross,
                color: AppColors.error500,
                width: 26,
              ),
              const WBox(8),
              Text(
                'Must have at least one symbol or number',
                style: AppTextStyle.caption1,
              ),
            ],
          ),
          child: Row(
            children: [
              SvgPicture.asset(AppIcons.icCheckRounded),
              const WBox(8),
              Text(
                'Must have at least one symbol or number',
                style: AppTextStyle.caption1,
              ),
            ],
          ),
        ),
        const HBox(4),
        Visibility(
          visible: validationPassword?.isContainSpace == true,
          replacement: Row(
            children: [
              SvgPicture.asset(AppIcons.icCheckRounded),
              const WBox(8),
              Text(
                'Can not contain spaces',
                style: AppTextStyle.caption1,
              ),
            ],
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                AppIcons.icCross,
                color: AppColors.error500,
                width: 26,
              ),
              const WBox(8),
              Text(
                'Can not contain spaces',
                style: AppTextStyle.caption1,
              ),
            ],
          ),
        ),
        const HBox(4),
      ],
    );
  }
}
