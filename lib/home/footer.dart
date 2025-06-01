import 'package:flutter/material.dart';
import 'package:prompt_echo/html_helper.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "developed by",
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withAlpha(100),
            ),
          ),
          const SizedBox(width: 4),
          IconButton(
            splashColor: Theme.of(context).colorScheme.onSurface.withAlpha(20),
            hoverColor: Theme.of(context).colorScheme.onSurface.withAlpha(20),
            highlightColor: Theme.of(
              context,
            ).colorScheme.onSurface.withAlpha(20),
            onPressed:
                () => HtmlHelper.openURL("https://github.com/commandiron"),
            icon: Image.asset(
              "assets/github.png",
              width: 16,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
