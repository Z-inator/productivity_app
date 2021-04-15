import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/subtasks.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Task_Feature/services/statuses_data.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:provider/provider.dart';

class TaskService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Collection reference
  CollectionReference _getTaskReference() {
    final User user = _auth.currentUser;
    if (user == null) {
      return null;
    } else {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('tasks');
    }
  }

  CollectionReference get tasks {
    return _getTaskReference();
  }

  // Snapshot Conversion to Task Model and Stream
  Stream<List<Task>> streamTasks(BuildContext context) {
    final CollectionReference ref = _getTaskReference();
    List<Project> projects;
    getProjects(context).then((projectList) => projects = projectList);
    List<Status> statuses;
    getStatuses(context).then((statusList) => statuses = statusList);
    return ref.snapshots().map((QuerySnapshot querySnapshot) =>
        querySnapshot.docs.map((QueryDocumentSnapshot queryDocument) {
          final Project project = projects[projects.indexWhere((project) =>
              project.projectName ==
              queryDocument.data()['projectName'].toString())];
          final Status status = statuses[statuses.indexWhere((status) =>
              status.statusName == queryDocument.data()['status'].toString())];
          return Task.fromFirestore(queryDocument, project, status);
        }).toList());
  }

  Future<List<Project>> getProjects(BuildContext context) async {
    final List<Project> projects =
        await Provider.of<ProjectService>(context).streamProjects().first;
    return projects;
  }

  Future<List<Status>> getStatuses(BuildContext context) async {
    final List<Status> statuses =
        await Provider.of<StatusService>(context).streamStatuses().first;
    return statuses;
  }

  List<Task> getTasksByStatus(List<Task> tasks, Status status) {
    return tasks
        .where((task) => task.status.statusName == status.statusName)
        .toList();
  }

  List<Task> getTasksByProject(List<Task> tasks, Project project) {
    return tasks
        .where((task) => task.project.projectID == project.projectID)
        .toList();
  }

  int getSubtaskCount(List<Subtask> subtasks, Task task) {
    return subtasks.length;
  }

  int getRecordedTime(List<TimeEntry> timeEntries, Task task) {
    int recordedTime = 0;
    timeEntries.forEach((entry) {
      recordedTime += entry.elapsedTime;
    });
    return recordedTime;
  }

  List<Task> getTasksDueToday(List<Task> tasks) {
    DateTime today = DateTime.now();
    return tasks
        .where((task) =>
            task.dueDate.year == today.year &&
            task.dueDate.month == today.month &&
            task.dueDate.day == today.day)
        .toList();
  }

  List<Task> getTasksDueThisWeek(List<Task> tasks) {
    DateTime today = DateTime.now();
    DateTime monday;
    DateTime sunday;
    for (var day = 0; day < 7; day++) {
      DateTime decreaseTemp = today.subtract(Duration(days: day));
      if (decreaseTemp.weekday == 1) {
        monday = decreaseTemp;
      }
      DateTime increaseTemp = today.add(Duration(days: day));
      if (increaseTemp.weekday == 7) {
        sunday = increaseTemp;
      }
    }
    return tasks
        .where((task) =>
            task.dueDate.isAfter(monday.subtract(Duration(days: 1))) &&
            task.dueDate.isBefore(sunday.add(Duration(days: 1))))
        .toList();
  }

  List<Task> getTasksPastDue(List<Task> tasks) {
    DateTime today = DateTime.now();
    return tasks
        .where((task) =>
            task.dueDate.isBefore(today) &&
            task.status.equalToComplete == false)
        .toList();
  }

  // Add Task
  Future<void> addTask({Map<String, dynamic> addData}) async {
    return _getTaskReference()
        .add(addData)
        .then((value) => print('Task Added'))
        .catchError((error) => print('Failed to add task: $error'));
  }

  // Update Task
  Future<void> updateTask(
      {String taskID, Map<String, dynamic> updateData}) async {
    return _getTaskReference()
        .doc(taskID)
        .update(updateData)
        .then((value) => print('Task Updated'))
        .catchError((error) => print('Failed to update task: $error'));
  }

  // Delete Task
  Future<void> deleteTask({String taskID}) async {
    return _getTaskReference()
        .doc(taskID)
        .delete()
        .then((value) => print('Task Deleted'))
        .catchError((error) => print('Failed to delete task: $error'));
  }
}
