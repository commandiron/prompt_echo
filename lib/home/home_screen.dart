import 'package:flutter/material.dart';
import 'package:prompt_echo/widget/blinking_widget.dart';
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
  bool _isPopupTriedBefore = false;
  bool _popupAllowed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          Expanded(
            child:
                _popupAllowed == false
                    ? Center(
                      child: BlinkingWidget(
                        child: PopUpButton(
                          isPopupTriedBefore: _isPopupTriedBefore,
                          popupTried: () {
                            setState(() {
                              _isPopupTriedBefore = true;
                            });
                          },
                          popupOpenedSuccessfully: () {
                            setState(() {
                              _popupAllowed = true;
                            });
                          },
                        ),
                      ),
                    )
                    : SizedBox.shrink(),
          ),
          PromptBar(),
          Expanded(flex: 2, child: Footer()),
        ],
      ),
    );
  }
}
