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
import 'package:productivity_app/Time_Feature/providers/time_entry_edit_state.dart';
import 'package:productivity_app/Time_Feature/screens/components/time_entry_edit_bottomsheet.dart';
import 'package:provider/provider.dart';

class EditBottomSheet {
  Future<dynamic> buildTaskEditBottomSheet(
      {BuildContext context,
      bool isUpdate,
      Task task,
      Project project,
      Status status}) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled:
            true, // Allows the modal to me dynamic and keeps the menu above the keyboard
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        builder: (BuildContext context) {
          return ChangeNotifierProvider(
              create: (context) => TaskEditState(isUpdate: isUpdate),
              builder: (context, child) {
                return TaskEditBottomSheet(
                    task: task, project: project, status: status);
              });
        });
  }

  Future<dynamic> buildProjectEditBottomSheet(
      {BuildContext context, bool isUpdate, Project project}) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled:
            true, // Allows the modal to me dynamic and keeps the menu above the keyboard
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        builder: (BuildContext context) {
          return ChangeNotifierProvider(
              create: (context) => ProjectEditState(isUpdate: isUpdate),
              child: ProjectEditBottomSheet(project: project));
        });
  }

  Future<dynamic> buildTimeEntryEditBottomSheet(
      {BuildContext context,
      bool isUpdate,
      TimeEntry entry,
      Project project,
      Task task}) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled:
            true, // Allows the modal to me dynamic and keeps the menu above the keyboard
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        builder: (BuildContext context) {
          return ChangeNotifierProvider(
              create: (context) => TimeEntryEditState(isUpdate: isUpdate),
              child: TimeEntryEditBottomSheet(
                  entry: entry, project: project, task: task));
        });
  }

  Future<dynamic> buildStatusEditBottomSheet(
      {BuildContext context, bool isUpdate, Status status}) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled:
            true, // Allows the modal to me dynamic and keeps the menu above the keyboard
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        builder: (BuildContext context) {
          return ChangeNotifierProvider(
              create: (context) => StatusEditState(),
              child: StatusEditBottomSheet(
                status: status,
                isUpdate: isUpdate,
              ));
        });
  }
}
