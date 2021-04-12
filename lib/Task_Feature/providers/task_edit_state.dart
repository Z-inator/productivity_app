import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:provider/provider.dart';

class TaskEditState with ChangeNotifier {
  Task newTask;
  bool isUpdate;

  TaskEditState({this.isUpdate}) : newTask = Task();

  void updateTask(Task task) {
    newTask = task;
  }

  void updateTaskName(String taskName) {
    newTask.taskName = taskName;
    notifyListeners();
  }

  void updateTaskProject(Project project) {
    newTask.project = project;
    print(newTask.project.projectName);
    notifyListeners();
  }

  void updateTaskStatus(Status status) {
    newTask.status = status;
    notifyListeners();
  }

  void updateTaskDueDate(DateTime dueDate) {
    if (newTask.dueDate.hour == 0) {
      newTask.dueDate = dueDate;
    } else {
      final DateTime temp = newTask.dueDate;
      newTask.dueDate = DateTime(
          dueDate.year, dueDate.month, dueDate.day, temp.hour, temp.minute);
    }
    notifyListeners();
  }

  void updateTaskDueTime(TimeOfDay dueTime) {
    if (newTask.dueDate.year == 0) {
      newTask.dueDate = DateTime(0, 0, 0, dueTime.hour, dueTime.minute);
    } else {
      final DateTime temp = newTask.dueDate;
      newTask.dueDate = DateTime(
          temp.year, temp.month, temp.day, dueTime.hour, dueTime.minute);
    }
    final DateTime temp = newTask.dueDate;
    newTask.dueDate =
        DateTime(temp.year, temp.month, temp.day, dueTime.hour, dueTime.minute);
    notifyListeners();
  }

  // void addTimeEntry(BuildContext context, int taskTime) {
  //   TimeService timeService = Provider.of<TimeService>(context);
  //   notifyListeners();
  // }
  
  void addTaskCreateDate(DateTime createDate) {
    newTask.createDate = createDate;
  }
}
