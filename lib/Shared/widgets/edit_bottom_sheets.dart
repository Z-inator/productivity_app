import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/providers/project_edit_state.dart';
import 'package:productivity_app/Task_Feature/providers/status_edit_state.dart';
import 'package:productivity_app/Task_Feature/providers/task_edit_state.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/status_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_edit_bottomsheet.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:provider/provider.dart';

// class EditBottomSheet {
// final inputObject;
// final ChangeNotifier editState;
// final Widget bottomSheet;
// final bool isUpdate;

// EditBottomSheet(
//     {this.inputObject, this.editState, this.bottomSheet, this.isUpdate});

Future<dynamic> buildShowModalBottomSheet(
    {BuildContext context, ChangeNotifier editState, Widget bottomSheet}) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Allows the modal to me dynamic and keeps the menu above the keyboard
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      builder: (BuildContext context) {
        return ChangeNotifierProvider(
            create: (context) => editState,
            builder: (context, child) {
              return bottomSheet;
            });
      });
}
