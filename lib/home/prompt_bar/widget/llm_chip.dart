import 'package:flutter/material.dart';
import 'package:prompt_echo/util/my_theme.dart';

import '../../../data/llm.dart';

class LlmChip extends StatefulWidget {
  const LlmChip({super.key, required this.llm, required this.onPressed});

  final Llm llm;
  final void Function(bool isActive) onPressed;

  @override
  State<LlmChip> createState() => _LlmChipState();
}

class _LlmChipState extends State<LlmChip> {
  late bool isActive;

  @override
  void initState() {
    isActive = widget.llm.echoStatus != EchoStatus.needCopyPaste;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Tooltip(
          message: widget.llm.name,
          child: IconButton(
            splashColor: Theme.of(context).colorScheme.onSurface.withAlpha(20),
            hoverColor: Theme.of(context).colorScheme.onSurface.withAlpha(20),
            highlightColor: Theme.of(
              context,
            ).colorScheme.onSurface.withAlpha(20),
            onPressed: () {
              setState(() {
                isActive = !isActive;
              });
              widget.onPressed(isActive);
            },
            icon: Image.asset(
              widget.llm.asset,
              color:
                  isActive
                      ? themeNotifier.value == ThemeMode.dark
                          ? widget.llm.darkThemeColor
                          : widget.llm.lightThemeColor
                      : Theme.of(context).colorScheme.onSurface.withAlpha(100),
              height: 30,
              opacity: AlwaysStoppedAnimation(isActive ? 1.0 : 0.3),
            ),
          ),
        ),
        Tooltip(
          message: widget.llm.echoStatus.text,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: widget.llm.echoStatus.color,
              maxRadius: 2,
            ),
          ),
        ),
      ],
    );
  }
}
