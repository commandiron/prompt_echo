import 'package:flutter/material.dart';
import 'package:prompt_echo/home/custom_app_bar.dart';
import 'package:prompt_echo/home/footer.dart';
import 'package:prompt_echo/home/prompt_bar/prompt_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [Spacer(), PromptBar(), Expanded(flex: 2, child: Footer())],
      ),
    );
  }
}
