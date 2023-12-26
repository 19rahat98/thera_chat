import 'package:flutter/material.dart';

class AppAdaptiveLayoutStepper extends StatelessWidget {
  const AppAdaptiveLayoutStepper({
    Key? key,
    this.footer,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: child,
                  ),
                  footer ?? const SizedBox(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
