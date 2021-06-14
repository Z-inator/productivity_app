import 'package:flutter/material.dart';

class EditBottomSheet {
  Future<dynamic> buildEditBottomSheet(
      {required BuildContext context, required Widget bottomSheet}) {
    return showModalBottomSheet(
        context: context,
        enableDrag: true,
        isScrollControlled:
            true, // Allows the modal to me dynamic and keeps the menu above the keyboard
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        builder: (BuildContext context) {
          return bottomSheet;
        });
  }

  // class EditBottomSheet {
  // Future<dynamic> buildEditBottomSheet(
  //     {BuildContext context, Widget bottomSheet}) {
  //   return showModalBottomSheet(
  //       context: context,
  //       enableDrag: true,
  //       // isDismissible: false,
  //       isScrollControlled:
  //           true, // Allows the modal to me dynamic and keeps the menu above the keyboard
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(25), topRight: Radius.circular(25))),
  //       builder: (BuildContext context) {
  //         return bottomSheet;
  //       });
  // }

  // void buildEditBottomSheet({BuildContext context, Widget bottomSheet}) {
  //   Future modalFuture = showModalBottomSheet(
  //       context: context,
  //       enableDrag: true,
  //       // isDismissible: false,
  //       isScrollControlled:
  //           true, // Allows the modal to me dynamic and keeps the menu above the keyboard
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(25), topRight: Radius.circular(25))),
  //       builder: (BuildContext context) {
  //         return bottomSheet;
  //       });
  //   modalFuture.then((value) {
  //     print(Provider.of<TaskEditState>(context, listen: false).newTask.project.projectName);
  //   });
  // }
}
