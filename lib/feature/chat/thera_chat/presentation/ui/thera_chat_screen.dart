import 'package:flutter/material.dart';
import 'package:theta_chat/common/presentation/widgets/app_bar/common_app_bar.dart';
import 'package:theta_chat/config/theme.dart';
import 'package:theta_chat/feature/chat/thera_chat/presentation/ui/widgets/chat_body_build.dart';

class TheraChatScreen extends StatelessWidget {
  const TheraChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey20,
      appBar: CommonAppBar(
        onPressLeading: () => Navigator.pop(context),
        leadingSize: 30,
        leadingIcon: AppIcons.icCross,
      ),
      body: const ChatBodyBuild(),
    );
  }
}
