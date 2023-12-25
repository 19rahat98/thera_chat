import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theta_chat/common/presentation/widgets/app_hbox_widget.dart';
import 'package:theta_chat/common/presentation/widgets/app_wbox_widget.dart';
import 'package:theta_chat/config/theme.dart';

class PasswordValidationErrors extends StatelessWidget {
  const PasswordValidationErrors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        Row(
          children: [
            SvgPicture.asset(AppIcons.icCheckRounded),
            const WBox(8),
            Text(
              'Must be at least 8 characters',
              style: AppTextStyle.caption1,
            ),
          ],
        ),
        const HBox(4),
        Row(
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
        const HBox(4),
        Row(
          children: [
            SvgPicture.asset(AppIcons.icCheckRounded),
            const WBox(8),
            Text(
              'Must have at least one symbol or number',
              style: AppTextStyle.caption1,
            ),
          ],
        ),
        const HBox(4),
        Row(
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
        const HBox(4),
      ],
    );
  }
}
