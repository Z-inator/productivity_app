import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/models/projects.dart';
import 'package:productivity_app/models/subtasks.dart';
import 'package:productivity_app/models/status.dart';
import 'package:productivity_app/shared_components/datetime_functions.dart';
import 'package:provider/provider.dart';

class Task {
  String taskID = '';
  String taskName = 'Default Name';
  Project project = Project();
  Status status = Status();
  int taskTime = 0;
  DateTime dueDate = DateTime(1);
  DateTime createDate = DateTime.now();
  // List<String> subtasks = [];

  Task(
      {this.taskID,
      this.taskName,
      this.project,
      this.status,
      this.taskTime,
      this.dueDate,
      this.createDate});



  factory Task.fromFirestore(DocumentSnapshot snapshot, BuildContext context) {
    List<Project> projects = Provider.of<List<Project>>(context);
    List<Status> statuses = Provider.of<List<Status>>(context);
    Map data = snapshot.data();
    Project associatedProject = projects
        .firstWhere((project) => project.projectName == data['pojectName']);
    print(associatedProject);
    Status status = statuses
        .firstWhere((status) => status.statusName == data['statusName']);
    return Task(
        taskID: snapshot.id ?? '',
        taskName: data['taskName'].toString() ?? '',
        project: associatedProject ?? Project(),
        status: status ?? Status(),
        taskTime: data['taskTime'] as int ?? 0,
        dueDate: (data['dueDate'] as Timestamp).toDate() ?? DateTime(1),
        createDate: (data['createDate'] as Timestamp).toDate() ?? DateTime(1));
  }
}

class TaskEditState with ChangeNotifier {
  Task newTask;

  void addTask() {
    newTask = Task();
  }

  void addTaskCreateDate(DateTime createDate) {
    newTask.createDate = createDate;
    notifyListeners();
  }

  void updateTask(Task task) {
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
    if (newTask.dueDate.hour == 0) {
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

  void updateTaskTime(int taskTime) {
    newTask.taskTime += taskTime;
    notifyListeners();
  }
}
