import 'package:flutter/material.dart';

import '../../../Task_Feature/Task_Feature.dart';

class TaskEditState extends ChangeNotifier {
  late Task newTask;
  final Task? oldTask;
  late bool showDueTimeButton;
  // DateTime? newDueDate;
  // TimeOfDay? newDueTime;

  TaskEditState({this.oldTask}) {
    if (oldTask != null) {
      newTask = oldTask!.copyTask();
    } else {
      newTask = Task(createDate: DateTime.now());
    }
    showDueTimeButton = newTask.dueDate != null;
  }

  void updateTaskName(String taskName) {
    newTask.taskName = taskName;
    notifyListeners();
  }

  void updateTaskProject(Project? project) {
    newTask.project = project;
    notifyListeners();
  }

  void updateTaskStatus(Status? status) {
    newTask.status = status;
    notifyListeners();
  }

  void updateTaskDueDate(DateTime? dueDate) {
    newTask.dueDate = dueDate;
    if (dueDate == null) {
      showDueTimeButton = false;
    } else {
      showDueTimeButton = true;
    }
    notifyListeners();
  }

  void updateTaskDueTime(TimeOfDay? dueTime) {
    if (dueTime != null) {
      newTask.dueTime = DateTime(1, 1, 1, dueTime.hour, dueTime.minute);
    } else {
      newTask.dueTime = null;
    }
    notifyListeners();
  }
}
