import 'package:flutter/material.dart';

class EchoButton extends StatelessWidget {
  const EchoButton({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      label: Text("Echo!"),
    );
  }
}