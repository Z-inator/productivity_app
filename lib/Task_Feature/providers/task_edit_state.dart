import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:provider/provider.dart';

class TaskEditState with ChangeNotifier {
  Task newTask;
  bool isUpdate;

  TaskEditState({this.isUpdate});

  void addTask() {
    isUpdate = false;
    newTask = Task();
  }

  void addTaskCreateDate(DateTime createDate) {
    newTask.createDate = createDate;
  }

  void updateTask(Task task) {
    isUpdate = true;
    newTask = task;
  }

  void updateTaskName(String taskName) {
    newTask.taskName = taskName;
    notifyListeners();
  }

  void updateTaskProject(Project projectName) {
    newTask.project = projectName;
    notifyListeners();
  }

  void updateTaskStatus(Status taskStatus) {
    newTask.status = taskStatus;
    notifyListeners();
  }

  void updateTaskDueDate(DateTime dueDate) {
    if (newTask.dueDate.hour == 1) {
      newTask.dueDate = dueDate;
    } else {
      DateTime temp = newTask.dueDate;
      newTask.dueDate = DateTime(
          dueDate.year, dueDate.month, dueDate.day, temp.hour, temp.minute);
    }
    notifyListeners();
  }

  void updateTaskDueTime(TimeOfDay dueTime) {
    if (newTask.dueDate.year == 1) {
      newTask.dueDate = DateTime(1, 1, 1, dueTime.hour, dueTime.minute);
    } else {
      DateTime temp = newTask.dueDate;
      newTask.dueDate = DateTime(
          temp.year, temp.month, temp.day, dueTime.hour, dueTime.minute);
    }
    DateTime temp = newTask.dueDate;
    newTask.dueDate =
        DateTime(temp.year, temp.month, temp.day, dueTime.hour, dueTime.minute);
    notifyListeners();
  }

  // void addTimeEntry(BuildContext context, int taskTime) {
  //   TimeService timeService = Provider.of<TimeService>(context);
  //   notifyListeners();
  // }
}
