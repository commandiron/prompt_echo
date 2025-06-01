import 'package:flutter/material.dart';

class EchoButton extends StatelessWidget {
  const EchoButton({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 47,
      child: FloatingActionButton.extended(
        onPressed: onPressed,
        label: Text("Echo!"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }
}