import 'package:flutter/material.dart';
import 'package:prompt_echo/util/my_theme.dart';

class EchoButton extends StatelessWidget {
  const EchoButton({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      extendedTextStyle: TextStyle(
        fontWeight:
            themeNotifier.value == ThemeMode.light
                ? FontWeight.normal
                : FontWeight.bold,
      ),
      label: Text("Echo!"),
    );
  }
}
