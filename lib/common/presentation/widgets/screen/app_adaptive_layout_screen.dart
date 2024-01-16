import 'package:flutter/material.dart';

class AppAdaptiveLayoutScreen extends StatelessWidget {
  const AppAdaptiveLayoutScreen({
    Key? key,
    this.footer,
    this.padding,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final Widget? footer;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: padding,
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
