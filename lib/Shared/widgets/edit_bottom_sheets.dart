import 'package:flutter/material.dart';


class EditBottomSheet {
  Future<dynamic> buildEditBottomSheet({BuildContext context, Widget bottomSheet}) {
    return showModalBottomSheet(
        context: context,
        // isDismissible: false,
        isScrollControlled:
            true, // Allows the modal to me dynamic and keeps the menu above the keyboard
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        builder: (BuildContext context) {
          return bottomSheet;
        });
  }
}
