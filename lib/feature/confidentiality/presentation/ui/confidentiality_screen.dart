import 'package:flutter/material.dart';
import 'package:theta_chat/common/presentation/widgets/app_bar/flex_app_bar.dart';
import 'package:theta_chat/common/presentation/widgets/app_hbox_widget.dart';
import 'package:theta_chat/config/theme.dart';

class ConfidentialityScreen extends StatelessWidget {
  const ConfidentialityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey20,
      appBar: const FlexAppBar(
        'Confidentiality',
        backgroundColor: AppColors.grey20,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TERMS OF USE',
              textAlign: TextAlign.start,
              style: AppTextStyle.h4,
            ),
            const HBox(12),
            Text(
              '''PLEASE READ THESE TERMS CAREFULLY BEFORE USING THIS APPLICATION. BY USING THE APP, YOU AGREE TO BE BOUND BY THE TERMS BELOW.

This app is currently in development as a Minimum Viable Product (MVP) to test functionality and user experience. It is not intended for actual therapeutic use or medical advice. 

Information shared is not confidential and will be used for research and development purposes only. Your anonymized responses may be analyzed as part of ongoing product evaluation and testing. 

While accuracy and helpfulness is the goal, responses provided by the app cannot be guaranteed. Do not rely on this app for any diagnosis or treatment recommendations regarding mental health. If you are experiencing a crisis, please contact emergency services.

You understand that as the MVP stage, the app features are preliminary and subject to change based on user feedback. Future versions may operate differently based on learnings during this testing period.

By using this app and providing feedback, you agree your data will be handled as described in our Privacy Policy. You also agree not to share any personal health information of other individuals through open-ended responses.

We cannot be held responsible for any loss or damages resulting from use of this application at its current experimental stage. Please contact us if you have any other questions or concerns.

Your use of this app constitutes agreement with these Terms of Use.''',
              textAlign: TextAlign.start,
              style: AppTextStyle.body1,
            ),
            const HBox(12),
          ],
        ),
      ),
    );
  }
}
