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

  // Future<List<Task>> getTasks(DocumentSnapshot snapshot) async {
  //   Map data = snapshot.data();

  // }

  factory Task.fromFirestore(DocumentSnapshot snapshot, List<Project> projects,
      List<Status> statuses) {
    Map data = snapshot.data();
    // print(projects.first.projectName);
    // print(statuses.first.statusName);
    // Project associatedProject = projects.firstWhere((project) {
    //   print(project.projectName);
    //   return data['pojectName'].toString() == project.projectName.toString();
    // }, orElse: () => null);
    int projectIndex = projects.indexWhere(
        (project) => project.projectName == data['projectName'].toString());
    Project associatedProject = projects[projectIndex];
    print(associatedProject.projectID);
    // Status status = statuses.firstWhere(
    //     (status) => status.statusName == data['statusName'],
    //     orElse: () => null);
    int statusIndex = statuses
        .indexWhere((status) => status.statusName == data['status'].toString());
    Status status = statuses[statusIndex];
    print(status.statusID);
    // TODO: this is where it fails
    Task newTask = Task(
        taskID: snapshot.id ?? '',
        taskName: data['taskName'] as String ?? '',
        project: associatedProject ?? Project(),
        status: status ?? Status(),
        taskTime: (data['taskTime'] as int) ?? 0,
        dueDate: (data['dueDate'] as Timestamp).toDate() ?? DateTime(1),
        createDate:
            (data['createDate'] as Timestamp).toDate() ?? DateTime.now());
    print(newTask.taskID);
    return newTask;
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
