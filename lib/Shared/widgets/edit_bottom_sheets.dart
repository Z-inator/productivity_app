import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/providers/project_edit_state.dart';
import 'package:productivity_app/Task_Feature/providers/task_edit_state.dart';
import 'package:productivity_app/Time_Feature/providers/time_entry_edit_state.dart';
import 'package:provider/provider.dart';

class EditBottomSheet {
  Future<dynamic> buildEditBottomSheet(
      {BuildContext context, Widget bottomSheet}) {
    return showModalBottomSheet(
        context: context,
        enableDrag: true,
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
  //     TaskEditState taskEditState = Provider.of<TaskEditState>(context);
  //     taskEditState.dispose();
  //     TimeEntryEditState timeEntryEditState =
  //         Provider.of<TimeEntryEditState>(context);
  //     timeEntryEditState.dispose();
  //     ProjectEditState projectEditState =
  //         Provider.of<ProjectEditState>(context);
  //     projectEditState.dispose();
  //   });
  // }

}
