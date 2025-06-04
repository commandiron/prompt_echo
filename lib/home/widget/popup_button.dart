import 'package:flutter/material.dart';
import 'package:prompt_echo/util/html_helper.dart';
import 'package:prompt_echo/util/my_theme.dart';
import 'package:prompt_echo/widget/blinking_widget.dart';
import 'package:universal_html/html.dart';

class PopUpButton extends StatefulWidget {
  const PopUpButton({super.key});

  @override
  State<PopUpButton> createState() => _PopUpButtonState();
}

class _PopUpButtonState extends State<PopUpButton> {
  bool _isPopupTriedBefore = false;
  bool _popupAllowed = false;
  bool _isDialogOpen = false;

  Future<void> openNewTabForAllowPopUp() async {
    if (_isPopupTriedBefore) {
      return;
    }
    await Future.delayed(Duration(milliseconds: HtmlHelper.getBrowserType() == BrowserType.safari ? 3000 : 5000));
    setState(() {
      _isPopupTriedBefore = true;
    });
    HtmlHelper.openURL("${Uri.base}popup");
    window.onMessage.listen((event) {
      if (event.data == 'popup_opened_successfully') {
        if (_isDialogOpen && mounted) {
          Navigator.of(context).pop();
        }
        setState(() {
          _popupAllowed = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Visibility(
        visible: !_popupAllowed,
        child: BlinkingWidget(
          child: FloatingActionButton.extended(
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            foregroundColor: Theme.of(context).colorScheme.primary,
            extendedTextStyle: TextStyle(
              fontWeight:
                  themeNotifier.value == ThemeMode.light
                      ? FontWeight.bold
                      : FontWeight.normal,
            ),
            onPressed: () async {
              openNewTabForAllowPopUp();
              if (_isDialogOpen) return;
              _isDialogOpen = true;
              showDialog<bool>(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: Row(
                        children: [
                          Text("Allow Popup"),
                          Spacer(),
                          CloseButton(),
                        ],
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "After a few seconds, you will see the popup blocker next to the address bar. Please click and allow.",
                          ),
                          SizedBox(height: 16),
                          Image.asset("assets/allow_popup.png", width: 360),
                        ],
                      ),
                    ),
              ).then((_) {
                _isDialogOpen = false;
              });
            },
            label: Text("Allow Popup Before Use!"),
          ),
        ),
      ),
    );
  }
}
