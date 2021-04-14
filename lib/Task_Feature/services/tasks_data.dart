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

  List<Task> getGroupedTasksByStatus(BuildContext context, Status status) {
    List<Task> tasks = Provider.of<List<Task>>(context);
    return tasks
        .where((task) => task.status.statusName == status.statusName)
        .toList();
  }

  List<Task> getGroupedTasksByProject(BuildContext context, Project project) {
    List<Task> tasks = Provider.of<List<Task>>(context);
    return tasks
        .where((task) => task.project.projectID == project.projectID)
        .toList();
  }

  int getSubtaskCount(BuildContext context, Task task) {
    List<Subtask> subtasks = Provider.of<List<Subtask>>(context);
    return subtasks.length;
  }

  int getRecordedTime(BuildContext context, Task task) {
    List<TimeEntry> timeEntries = Provider.of<List<TimeEntry>>(context);
    int recordedTime = 0;
    timeEntries.forEach((entry) {
      recordedTime += entry.elapsedTime;
    });
    return recordedTime;
  }

  List<Task> getTasksDueToday(BuildContext context) {
    List<Task> tasks = Provider.of<List<Task>>(context);
    DateTime today = DateTime.now();
    return tasks
        .where((task) =>
            task.dueDate.year == today.year &&
            task.dueDate.month == today.month &&
            task.dueDate.day == today.day)
        .toList();
  }

  List<Task> getTasksDueThisWeek(BuildContext context) {
    List<Task> tasks = Provider.of<List<Task>>(context);
    DateTime today = DateTime.now();
    DateTime monday;
    DateTime sunday;
    // int count = 0;
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
    // while (monday == null && sunday == null) {
    //   DateTime decreaseTemp = today.subtract(Duration(days: count));
    //   DateTime increaseTemp = today.add(Duration(days: count));
    //   if (decreaseTemp.weekday == 1) {
    //     monday = decreaseTemp;
    //   }
    //   if (increaseTemp.weekday == 7) {
    //     sunday = increaseTemp;
    //   }
    //   count++;
    // }
    return tasks
        .where((task) =>
            task.dueDate.isAfter(monday.subtract(Duration(days: 1))) &&
            task.dueDate.isBefore(sunday.add(Duration(days: 1))))
        .toList();
  }

  List<Task> getTasksPastDue(BuildContext context) {
    List<Task> tasks = Provider.of<List<Task>>(context);
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
        .add(Map<String, dynamic>.from(addData))
        .then((value) => print('Task Added'))
        .catchError((error) => print('Failed to add task: $error'));
  }

  // Update Task
  Future<void> updateTask({String taskID, Map updateData}) async {
    return _getTaskReference()
        .doc(taskID)
        .update(Map<String, dynamic>.from(updateData))
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
