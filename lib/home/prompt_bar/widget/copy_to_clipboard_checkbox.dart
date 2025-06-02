import 'package:flutter/material.dart';

class CopyToCliboardCheckBox extends StatelessWidget {
  const CopyToCliboardCheckBox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool? value;
  final void Function(bool? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(value: value, onChanged: onChanged),
        Text(
          "Copy to clipboard when press echo.",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}