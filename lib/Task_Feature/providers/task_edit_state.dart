import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:provider/provider.dart';

class TaskEditState extends ChangeNotifier {
  Task newTask;
  final Task oldTask;
  bool showDueTimeButton;
  DateTime newDueDate;
  TimeOfDay newDueTime;

  TaskEditState({this.oldTask}) {
    if (oldTask != null) {
      newTask = oldTask.copyTask();
      if (oldTask.dueDate.year != 1) {
        newDueDate = oldTask.dueDate;
        if (oldTask.dueDate.microsecond != 555) {
          newDueTime = TimeOfDay.fromDateTime(oldTask.dueDate);
        }
      }
    } else {
      newTask = Task();
    }
    showDueTimeButton = newTask.dueDate.year != 1;
  }

  void updateTaskName(String taskName) {
    newTask.taskName = taskName;
    notifyListeners();
  }

  void updateTaskProject(Project project) {
    newTask.project = project;
    notifyListeners();
  }

  void updateTaskStatus(Status status) {
    newTask.status = status;
    notifyListeners();
  }

  void updateTaskDueDate(DateTime dueDate) {
    newDueDate = dueDate;
    if (dueDate == null) {
      showDueTimeButton = false;
      newDueTime = null;
    } else {
      showDueTimeButton = true;
    }
    notifyListeners();
  }

  void updateTaskDueTime(TimeOfDay dueTime) {
    newDueTime = dueTime;
    notifyListeners();
  }

  void combineDueDate() {
    newTask.dueDate = DateTime(newDueDate.year, newDueDate.month,
        newDueDate.day, newDueTime.hour, newDueTime.minute);
  }

  void addTaskCreateDate(DateTime createDate) {
    newTask.createDate = createDate;
  }
}
