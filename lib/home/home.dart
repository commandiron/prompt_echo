import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prompt_echo/data/llm.dart';
import 'package:prompt_echo/home/widget/llm_chip.dart';
import 'package:prompt_echo/html_helper.dart';

import '../my_theme.dart';

const int compactModeBreakWidth = 600;

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 100,
        iconTheme: Theme.of(context).iconTheme,
        title: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Row(
            children: [
              Image.asset(
                "assets/logo.png",
                width:
                    MediaQuery.of(context).size.width > compactModeBreakWidth
                        ? 60
                        : 40,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Prompt Echo",
                    style:
                        MediaQuery.of(context).size.width >
                                compactModeBreakWidth
                            ? Theme.of(
                              context,
                            ).textTheme.titleLarge?.copyWith(letterSpacing: 2)
                            : Theme.of(
                              context,
                            ).textTheme.titleSmall?.copyWith(letterSpacing: 2),
                  ),
                  Text(
                    "All in one ai prompt bar",
                    style:
                        MediaQuery.of(context).size.width >
                                compactModeBreakWidth
                            ? Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(fontSize: 14)
                            : Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),

              const Spacer(),
              ValueListenableBuilder<ThemeMode>(
                valueListenable: themeNotifier,
                builder: (context, currentMode, _) {
                  return IconButton(
                    onPressed: () => themeNotifier.toggleTheme(),
                    icon: Icon(
                      currentMode == ThemeMode.dark
                          ? Icons.light_mode
                          : Icons.dark_mode,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Spacer(),
            EchoSearch(),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "developed by",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withAlpha(100),
                      ),
                    ),
                    SizedBox(width: 4,),
                    IconButton(
                      splashColor: Theme.of(
                        context,
                      ).colorScheme.onSurface.withAlpha(20),
                      hoverColor: Theme.of(
                        context,
                      ).colorScheme.onSurface.withAlpha(20),
                      highlightColor: Theme.of(
                        context,
                      ).colorScheme.onSurface.withAlpha(20),
                      onPressed:
                          () => HtmlHelper.openURL(
                            "https://github.com/commandiron",
                          ),
                      icon: Image.asset(
                        "assets/github.png",
                        width: 16,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EchoSearch extends StatefulWidget {
  const EchoSearch({super.key});

  @override
  State<EchoSearch> createState() => _EchoSearchState();
}

class _EchoSearchState extends State<EchoSearch> {
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
                        ? EchoButton(onPressed: () => search())
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
                      child: Text(
                        "* Don't forget to allow pop-ups next to the address bar on your first try. Then try again.",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: clipboardSwitchValue,
                          onChanged: (value) {
                            setState(() {
                              clipboardSwitchValue = value ?? false;
                            });
                          },
                        ),
                        Text(
                          "Copy to clipboard when press echo.",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
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
