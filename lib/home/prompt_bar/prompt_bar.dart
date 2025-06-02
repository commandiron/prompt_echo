import 'dart:async';

import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prompt_echo/constants.dart';
import 'package:prompt_echo/data/llm.dart';
import 'package:prompt_echo/home/prompt_bar/widget/echo_button.dart';
import 'package:prompt_echo/home/prompt_bar/widget/llm_chip.dart';
import 'package:prompt_echo/html_helper.dart';

class PromptBar extends StatefulWidget {
  const PromptBar({super.key});

  @override
  State<PromptBar> createState() => _PromptBarState();
}

class _PromptBarState extends State<PromptBar> {
  final TextEditingController controller = TextEditingController();
  final Set<Llm> searchSet = Set.from(
    Llm.items.where((e) => e.echoStatus != EchoStatus.needCopyPaste),
  );

  bool clipboardSwitchValue = true;

  void search() {
    if (clipboardSwitchValue) {
      Clipboard.setData(ClipboardData(text: controller.text));
    }

    final sortedSearchList = sortSearchList();
    if (sortedSearchList.isEmpty) return;

    for (var llm in sortedSearchList) {
      HtmlHelper.openURL(llm.url + controller.text);
    }
  }

  List<Llm> sortSearchList() {
    return searchSet.toList()..sort((a, b) => a.index.compareTo(b.index));
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 800),
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
                      searchSet.add(llm);
                    }
                    if (!isActive) {
                      searchSet.remove(llm);
                    }

                    setState(() {});
                  },
                );
              }),
            ),
          ),
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width:
                    MediaQuery.of(context).size.width > compactModeBreakWidth
                        ? 100
                        : 32,
              ),
              Expanded(
                child: Column(
                  children: [
                    TextField(
                      controller: controller,
                      maxLines: 3,
                      minLines: 2,
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
                            searchSet.isNotEmpty
                                ? "Prompt to ${sortSearchList().map((e) => e.name).toList()}"
                                : "Prompt yourself :)",
                        hintStyle: Theme.of(
                          context,
                        ).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      onSubmitted: (value) => search(),
                      onEditingComplete: () => search(),
                    ),
                  ],
                ),
              ),
              Container(
                width:
                    MediaQuery.of(context).size.width > compactModeBreakWidth
                        ? 100
                        : 32,
                alignment: Alignment.center,
                child:
                    MediaQuery.of(context).size.width > compactModeBreakWidth
                        ? Column(
                          children: [EchoButton(onPressed: () => search())],
                        )
                        : null,
              ),
            ],
          ),
          if (MediaQuery.of(context).size.width < compactModeBreakWidth)
            EchoButton(onPressed: () => search()),
          Row(
            children: [
              SizedBox(
                width:
                    MediaQuery.of(context).size.width > compactModeBreakWidth
                        ? 100
                        : 32,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: AllowPopUpButton(),
                    ),
                    CopyToCliboardCheckBox(value: clipboardSwitchValue, onChanged:(value) {
                      setState(() {
              clipboardSwitchValue = value ?? false;
            });
                    },),

                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "* Claude, Gemini, and DeepSeek are not supported queries. You can simply paste your prompt using 'Copy to clipboard when echo' and press enter.",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width:
                    MediaQuery.of(context).size.width > compactModeBreakWidth
                        ? 100
                        : 32,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CopyToCliboardCheckBox extends StatelessWidget {
  const CopyToCliboardCheckBox({super.key, required this.value, required this.onChanged});

  final bool? value;
  final void Function(bool? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        Text(
          "Copy to clipboard when press echo.",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class AllowPopUpButton extends StatelessWidget {
  const AllowPopUpButton({super.key});

  Future<void> openNewTabForAllowPopUp() async {
    await Future.delayed(Duration(milliseconds: 5500));
    HtmlHelper.openURL(Uri.base.toString());
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
                  children: [
                    Text("Allow Popup"),
                    SizedBox(width: 4),
                    CountDownText(),
                  ],
                ),
                content: Text(
                  "After few seconds, you will see pop-up blocker next to the address bar. Please click on and allow.",
                ),
                actions: [CloseButton()],
              ),
        );
      },
      child: Text(
        "* Don't forget to allow pop-up before start.",
        style: Theme.of(context).textTheme.bodySmall,
      ),
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
    return countdown > 0 ? Text(countdown.toString()) : SizedBox.shrink();
  }
}
