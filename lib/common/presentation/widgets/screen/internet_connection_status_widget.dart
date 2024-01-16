import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:theta_chat/common/presentation/widgets/app_internet_problem_widget.dart';

/// виджет реагирует на интернет соединение, и если проподает то показывает виджет алерта
class InternetConnectionStatusWidget extends StatelessWidget {
  const InternetConnectionStatusWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    /// Подписка на сокет с собитяма на интернет соединение
    return StreamBuilder<InternetConnectionStatus>(
      stream: InternetConnectionChecker.createInstance(
        checkInterval: const Duration(seconds: 3),
      ).onStatusChange,
      builder: (context, snapshot) {
        if (snapshot.data == InternetConnectionStatus.disconnected) {
          return const AppInternetProblemWidget();
        }
        return child;
      },
    );
  }
}
