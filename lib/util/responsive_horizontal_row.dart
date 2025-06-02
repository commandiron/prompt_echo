import 'package:flutter/material.dart';
import 'package:prompt_echo/util/constants.dart';

class ResponsiveAppRow extends StatelessWidget {
  const ResponsiveAppRow({
    super.key,
    this.leadingWidget,
    required this.content,
    this.trailingWidget,
  });

  final Widget? leadingWidget;
  final Widget content;
  final Widget? trailingWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width:
              MediaQuery.of(context).size.width > compactModeBreakWidth
                  ? 250
                  : 32,
          child: leadingWidget,
        ),
        Expanded(child: content),
        SizedBox(
          width:
              MediaQuery.of(context).size.width > compactModeBreakWidth
                  ? 250
                  : 32,
          child: trailingWidget,
        ),
      ],
    );
  }
}
