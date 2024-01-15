import 'package:flutter/material.dart';
import 'package:theta_chat/config/theme.dart';

class AppTermsAndPolicyWidget extends StatelessWidget {
  const AppTermsAndPolicyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        text: 'By selecting Agree and continue, I agree to ',
        style: AppTextStyle.body2,
        children: <TextSpan>[
          TextSpan(
            text: 'Th3ra',
            style: AppTextStyle.body2.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: ' Terms of Service, Payments Terms of Service ',
            style: AppTextStyle.body2.copyWith(
              color: AppColors.inDevPrimary,
            ),
          ),
          TextSpan(
            text: 'and',
            style: AppTextStyle.body2,
          ),
          TextSpan(
            text: ' Notification Policy',
            style: AppTextStyle.body2.copyWith(
              color: AppColors.inDevPrimary,
            ),
          ),
          TextSpan(
            text: ' and acknowledge the ',
            style: AppTextStyle.body2,
          ),
          TextSpan(
            text: 'Privacy Policy.',
            style: AppTextStyle.body2.copyWith(
              color: AppColors.inDevPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
