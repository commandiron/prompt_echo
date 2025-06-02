import 'package:flutter/material.dart';

class CopyToCliboardCheckBox extends StatelessWidget {
  const CopyToCliboardCheckBox({
    super.key,
    required this.value,
    required this.onChanged,
    this.message,
  });

  final bool? value;
  final void Function(bool? value)? onChanged;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return (RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodySmall,
        children: [
          WidgetSpan(alignment: PlaceholderAlignment.middle,child: Checkbox(value: value, onChanged: onChanged)),
          TextSpan(text: "Copy to clipboard when press echo."),
          if(message != null)
            TextSpan(text: " ($message)")
        ],
      ),
    ));
  }
}
