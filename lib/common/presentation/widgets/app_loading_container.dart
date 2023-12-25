import 'package:flutter/material.dart';
import 'package:theta_chat/config/theme.dart';

class AppLoadingContainer extends StatelessWidget {
  const AppLoadingContainer({
    Key? key,
    required this.isLoading,
    required this.child,
  }) : super(key: key);

  final bool isLoading;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          ColoredBox(
            color: AppColors.grey500.withOpacity(0.4),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
