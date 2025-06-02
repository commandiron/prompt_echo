import 'package:flutter/material.dart';
import 'package:prompt_echo/widget/custom_app_bar.dart';
import 'package:prompt_echo/home/widget/footer.dart';
import 'package:prompt_echo/home/widget/popup_button.dart';
import 'package:prompt_echo/home/widget/prompt_bar/prompt_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    precacheImage(AssetImage("assets/allow_popup.png"), context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          Expanded(child: PopUpButton()),
          PromptBar(),
          Expanded(flex: 2, child: Footer()),
        ],
      ),
    );
  }
}
