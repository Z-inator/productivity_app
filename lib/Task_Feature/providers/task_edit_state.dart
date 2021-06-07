import 'package:flutter/material.dart';

import '../../../Task_Feature/Task_Feature.dart';

class TaskEditState extends ChangeNotifier {
  late Task newTask;
  final Task? oldTask;
  bool? showDueTimeButton;
  DateTime? newDueDate;
  TimeOfDay? newDueTime;

  TaskEditState({this.oldTask}) {
    if (oldTask != null) {
      newTask = oldTask!.copyTask();
      if (oldTask!.dueDate != null) {
        newDueDate = DateTime(oldTask!.dueDate!.year, oldTask!.dueDate!.month, oldTask!.dueDate!.day);
        newDueTime = TimeOfDay.fromDateTime(oldTask!.dueDate!);
      }
    } else {
      newTask = Task();
    }
    showDueTimeButton = newDueTime?.hour != 0;
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
    newDueDate = dueDate;
    if (dueDate == null) {
      showDueTimeButton = false;
      newDueTime = null;
    } else {
      showDueTimeButton = true;
    }
    notifyListeners();
  }

  void updateTaskDueTime(TimeOfDay? dueTime) {
    newDueTime = dueTime;
    notifyListeners();
  }

  void combineDueDate() {
    newTask.dueDate = DateTime(newDueDate!.year, newDueDate!.month,
        newDueDate!.day, newDueTime!.hour, newDueTime!.minute);
  }

  void addTaskCreateDate(DateTime createDate) {
    newTask.createDate = createDate;
  }
}
