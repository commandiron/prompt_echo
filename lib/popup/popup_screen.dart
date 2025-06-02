import 'package:flutter/material.dart';
import 'package:prompt_echo/home/custom_app_bar.dart';
import 'package:universal_html/html.dart';

class PopupScreen extends StatefulWidget {
  const PopupScreen({super.key});

  @override
  State<PopupScreen> createState() => _PopupScreenState();
}

class _PopupScreenState extends State<PopupScreen> {
  @override
  void initState() {
    window.opener?.postMessage('popup_opened_successfully', window.location.origin);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Text(
          "Popup permission successful. Please close this window.",
          style: Theme.of(context).textTheme.displaySmall,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
