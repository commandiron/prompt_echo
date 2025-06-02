import 'dart:async';

import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prompt_echo/home/prompt_bar/widget/copy_to_clipboard_checkbox.dart';
import 'package:prompt_echo/util/constants.dart';
import 'package:prompt_echo/data/llm.dart';
import 'package:prompt_echo/home/prompt_bar/widget/echo_button.dart';
import 'package:prompt_echo/home/prompt_bar/widget/llm_chip.dart';
import 'package:prompt_echo/util/html_helper.dart';
import 'package:prompt_echo/util/responsive_horizontal_row.dart';

class PromptBar extends StatefulWidget {
  const PromptBar({super.key});

  @override
  State<PromptBar> createState() => _PromptBarState();
}

class _PromptBarState extends State<PromptBar> {
  final Set<Llm> llmSet = Set.from(
    Llm.items.where((e) => e.echoStatus != EchoStatus.needCopyPaste),
  );

  final TextEditingController controller = TextEditingController();

  bool clipboardSwitchValue = true;

  void search() {
    if (clipboardSwitchValue) {
      Clipboard.setData(ClipboardData(text: controller.text));
    }

    final sortedLlmList = getSortedLlmList();
    if (sortedLlmList.isEmpty) return;

    for (var llm in sortedLlmList) {
      HtmlHelper.openURL(llm.url + controller.text);
    }
  }

  List<Llm> getSortedLlmList() {
    return llmSet.toList()..sort((a, b) => a.index.compareTo(b.index));
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 1200),
      child: SeparatedColumn(
        separatorBuilder: () => SizedBox(height: 16),
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.of(
              Llm.items.map((llm) {
                return LlmChip(
                  llm: llm,
                  onPressed: (isActive) {
                    if (isActive) {
                      llmSet.add(llm);
                    }
                    if (!isActive) {
                      llmSet.remove(llm);
                    }
                    setState(() {});
                  },
                );
              }),
            ),
          ),
          ResponsiveAppRow(
            content: TextField(
              controller: controller,
              maxLines: 3,
              minLines: 1,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                hintText:
                    llmSet.isNotEmpty
                        ? "Prompt to ${getSortedLlmList().map((e) => e.name).toList()}"
                        : "Prompt yourself :)",
                hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              onSubmitted: (value) => search(),
              onEditingComplete: () => search(),
            ),
            trailingWidget:
                MediaQuery.of(context).size.width > compactModeBreakWidth
                    ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 8),
                        EchoButton(onPressed: () => search()),
                        SizedBox(width: 8),
                        AllowPopUpButton(),
                      ],
                    )
                    : null,
          ),
          if (MediaQuery.of(context).size.width < compactModeBreakWidth)
            EchoButton(onPressed: () => search()),
          if (MediaQuery.of(context).size.width < compactModeBreakWidth)
            AllowPopUpButton(),
          ResponsiveAppRow(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CopyToCliboardCheckBox(
                  value: clipboardSwitchValue,
                  onChanged: (value) {
                    setState(() {
                      clipboardSwitchValue = value ?? false;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "* Claude, Gemini, and DeepSeek are not supported queries. You can simply paste your prompt using 'Copy to clipboard when echo' and press enter.",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "* Don't forget to allow popup before start.",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AllowPopUpButton extends StatelessWidget {
  const AllowPopUpButton({super.key});

  Future<void> openNewTabForAllowPopUp() async {
    await Future.delayed(Duration(milliseconds: 5500));
    HtmlHelper.openURL("${Uri.base}popup");
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        openNewTabForAllowPopUp();
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Row(
                  children: [Text("Allow Popup"), Spacer(), CloseButton()],
                ),
                content: Column(
                  children: [
                    Text(
                      "After a few seconds, you will see the popup blocker next to the address bar. Please click and allow.",
                    ),
                    SizedBox(height: 16,),
                  ],
                ),
              ),
        );
      },
      child: Text("Allow Popup"),
    );
  }
}

class CountDownText extends StatefulWidget {
  const CountDownText({super.key});

  @override
  State<CountDownText> createState() => _CountDownTextState();
}

class _CountDownTextState extends State<CountDownText> {
  int countdown = 5;
  late Timer _timer;
  void startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    startCountdown();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      countdown.toString(),
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}
