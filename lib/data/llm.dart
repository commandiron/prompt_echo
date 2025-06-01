import 'package:flutter/material.dart';

enum EchoStatus {
  working,
  needPressEnter,
  needCopyPaste;

  String get text {
    switch (this) {
      case EchoStatus.working:
        return 'Working';
      case EchoStatus.needPressEnter:
        return 'Partially Working; Need To Press Enter';
      case EchoStatus.needCopyPaste:
        return 'Not Working; Need to Copy Paste and Press Enter';
    }
  }

  Color get color {
    switch (this) {
      case EchoStatus.working:
        return Colors.green;
      case EchoStatus.needPressEnter:
        return Colors.orange;
      case EchoStatus.needCopyPaste:
        return Colors.red;
    }
  }
}

class Llm {
  final int index;
  final String name;
  final String asset;
  final Color? darkThemeColor;
  final Color? lightThemeColor;
  final String url;
  final EchoStatus echoStatus;

  Llm(this.index, this.name, this.asset, this.darkThemeColor, this.lightThemeColor, this.url, this.echoStatus);

  static final List<Llm> items = [
    Llm(
      0,
      "ChatGPT",
      "assets/chatgpt.png",
      Colors.white,
      Colors.black,
      "https://chatgpt.com/?q=",
      EchoStatus.working,
    ),
    Llm(
      1,
      "Grok",
      "assets/grok.png",
      Colors.white,
      Colors.black,
      "https://grok.com/?q=",
      EchoStatus.working,
    ),
    Llm(
      2,
      "Claude",
      "assets/claude.png",
      null,
      null,
      "https://claude.ai/new?q=",
      EchoStatus.needPressEnter,
    ),
    Llm(
      3,
      "Gemini",
      "assets/gemini.png",
      null,
      null,
      "https://gemini.google.com/?q=",
      EchoStatus.needCopyPaste,
    ),
    Llm(
      4,
      "deepseek",
      "assets/deepseek.png",
      null,
      null,
      "https://chat.deepseek.com/?q=",
      EchoStatus.needCopyPaste,
    ),
  ];
}
