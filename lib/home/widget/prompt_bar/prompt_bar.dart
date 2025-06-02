import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prompt_echo/home/widget/prompt_bar/widget/copy_to_clipboard_checkbox.dart';
import 'package:prompt_echo/util/constants.dart';
import 'package:prompt_echo/data/llm.dart';
import 'package:prompt_echo/home/widget/prompt_bar/widget/echo_button.dart';
import 'package:prompt_echo/home/widget/prompt_bar/widget/llm_chip.dart';
import 'package:prompt_echo/util/html_helper.dart';
import 'package:prompt_echo/widget/responsive_horizontal_row.dart';

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
                    ? Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: EchoButton(onPressed: () => search()),
                    )
                    : null,
          ),
          if (MediaQuery.of(context).size.width < compactModeBreakWidth)
            EchoButton(onPressed: () => search()),
          ResponsiveAppRow(
            content: CopyToCliboardCheckBox(
              value: clipboardSwitchValue,
              onChanged: (value) {
                setState(() {
                  clipboardSwitchValue = value ?? false;
                });
              },
              message:
                  "Claude, Gemini, and DeepSeek are not supported queries. You can simply paste & enter your prompt.",
            ),
          ),
        ],
      ),
    );
  }
}
