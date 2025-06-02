import 'package:flutter/material.dart';
import 'package:prompt_echo/util/html_helper.dart';
import 'package:universal_html/html.dart';

class PopUpButton extends StatefulWidget {
  const PopUpButton({
    super.key,
    required this.isPopupTriedBefore,
    required this.popupTried,
    required this.popupOpenedSuccessfully,
  });

  final bool isPopupTriedBefore;
  final void Function() popupTried;
  final void Function() popupOpenedSuccessfully;

  @override
  State<PopUpButton> createState() => _PopUpButtonState();
}

class _PopUpButtonState extends State<PopUpButton> {
  bool _isDialogOpen = false;
  Future<void> openNewTabForAllowPopUp() async {
    if (widget.isPopupTriedBefore) {
      return;
    }
    await Future.delayed(Duration(milliseconds: 3000));
    widget.popupTried();
    HtmlHelper.openURL("${Uri.base}popup");
    window.onMessage.listen((event) {
      if (event.data == 'popup_opened_successfully') {
        if (_isDialogOpen && mounted) {
          Navigator.of(context).pop();
        }
        widget.popupOpenedSuccessfully();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () async {
        openNewTabForAllowPopUp();
        if (_isDialogOpen) return;
        _isDialogOpen = true;
        showDialog<bool>(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Row(
                  children: [Text("Allow Popup"), Spacer(), CloseButton()],
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
    );
  }
}