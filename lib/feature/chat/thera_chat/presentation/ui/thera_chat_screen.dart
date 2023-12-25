import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:theta_chat/common/presentation/widgets/app_bar/common_app_bar.dart';
import 'package:theta_chat/config/theme.dart';
import 'package:theta_chat/feature/chat/thera_chat/presentation/ui/widgets/chat_body_build.dart';
import 'package:theta_chat/feature/chat/thera_chat/presentation/ui/widgets/chat_internet_problem_widget.dart';

class TheraChatScreen extends StatefulWidget {
  const TheraChatScreen({Key? key}) : super(key: key);

  @override
  State<TheraChatScreen> createState() => _TheraChatScreenState();
}

class _TheraChatScreenState extends State<TheraChatScreen> {
  var connection = InternetConnectionStatus.connected;

  @override
  void didChangeDependencies() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          setState(() {
            connection = InternetConnectionStatus.connected;
          });
          break;
        case InternetConnectionStatus.disconnected:
          setState(() {
            connection = InternetConnectionStatus.disconnected;
          });
          break;
      }
    });
    super.didChangeDependencies();
  }

  var chatting = [
    'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation venia consequat sunt nostrud amet.cccc',
    'Привет, меня зовут Эмма.',
    'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation venia consequat sunt nostrud amet.cccc',
    'Привет, меня зовут Эмма.',
    'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation venia consequat sunt nostrud amet.cccc',
    'Привет, меня зовут Эмма.',
    'Привет, меня зовут Эмма.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey20,
      appBar: const CommonAppBar(
        leadingSize: 30,
        leadingIcon: AppIcons.icCross,
      ),
      body: Builder(
        builder: (context) {
          if (connection == InternetConnectionStatus.connected) {
            return ChatBodyBuild(chatting);
          }

          return const ChatInternetProblemWidget();
        },
      ),
    );
  }
}
