import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Time_Feature/Time_Feature.dart';
import '../../../Task_Feature/Task_Feature.dart';
import '../../../Shared/Shared.dart';

class TaskService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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

  // Stream<List<Task>> streamTasks(Project project, Status status) {
  //   FirebaseFirestore.instance.snapshotsInSync()
  //   var ref = firestore
  //       .collection('users')
  //       .doc(user.uid)
  //       .collection('tasks')
  //       .withConverter<Task>(
  //         fromFirestore: (snapshot, _) =>
  //             Task.fromJson(snapshot.data(), snapshot, project, status),
  //         toFirestore: (task, _) => task.toJson(),
  //       );
  //   ref.
  // }

  // Snapshot Conversion to Task Model and Stream
  Stream<List<Task>> streamTasks(BuildContext context) {
    List<Project> projects;
    getProjects(context).then((projectList) => projects = projectList);
    List<Status> statuses;
    getStatuses(context).then((statusList) => statuses = statusList);
    return tasks.snapshots().map((QuerySnapshot querySnapshot) =>
        querySnapshot.docs.map((QueryDocumentSnapshot queryDocument) {
          final Project project = projects.firstWhere((project) =>
              project.id == queryDocument.data()['project'].toString());
          final Status status = statuses.firstWhere((status) =>
              status.id == queryDocument.data()['status'].toString());
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

  List<Map<Status, List<Task>>> getTasksByStatus(
      List<Task> tasks, List<Status> statuses) {
    List<Map<Status, List<Task>>> statusMapList = [];
    List<Task> noStatusTasks = [];
    for (Status status in statuses) {
      List<Task> tempTasks =
          tasks.where((task) => task.status.id == status.id).toList();
      statusMapList.add({status: tempTasks});
    }
    noStatusTasks.addAll(tasks.where((task) => task.project.id.isEmpty));
    if (noStatusTasks.isNotEmpty) {
      statusMapList.add({Status(statusName: 'No Status'): noStatusTasks});
    }
    return statusMapList;
  }

  List<Map<Project, List<Task>>> getTasksByProject(
      List<Task> tasks, List<Project> projects) {
    List<Map<Project, List<Task>>> projectMapList = [];
    List<Task> noProjectTasks = [];
    for (Project project in projects) {
      List<Task> tempTasks =
          tasks.where((task) => task.project.id == project.id).toList();
      projectMapList.add({project: tempTasks});
    }
    noProjectTasks.addAll(tasks.where((task) => task.project.id.isEmpty));
    if (noProjectTasks.isNotEmpty) {
      projectMapList.add({Project(projectName: 'No Project'): noProjectTasks});
    }
    return projectMapList;
  }

  List<Map<String, List<Task>>> getTasksByDueDate(List<Task> tasks) {
    List<Map<String, List<Task>>> dueDateMapList = [];
    List<Task> noDueDateTasks = [];
    List<DateTime> days = [];
    for (Task task in tasks) {
      DateTime tempDate =
          DateTime(task.dueDate.year, task.dueDate.month, task.dueDate.day);
      if (!days.contains(tempDate)) {
        days.add(tempDate);
      }
    }
    days.sort((a, b) => a.compareTo(b));
    for (DateTime day in days) {
      List<Task> tempTasks = tasks
          .where((task) =>
              task.dueDate.year == day.year &&
              task.dueDate.month == day.month &&
              task.dueDate.day == day.day)
          .toList();
      dueDateMapList
          .add({DateTimeFunctions().dateTimeToTextDate(date: day): tempTasks});
    }
    noDueDateTasks
        .addAll(tasks.where((task) => task.dueDate.microsecond == 555));
    dueDateMapList.add({'No Due Date': noDueDateTasks});
    return dueDateMapList;
  }

  List<Map<String, List<Task>>> getTasksByCreateDate(List<Task> tasks) {
    List<Map<String, List<Task>>> createDateMapList = [];
    List<DateTime> days = [];
    for (Task task in tasks) {
      DateTime tempDate = DateTime(
          task.createDate.year, task.createDate.month, task.createDate.day);
      if (!days.contains(tempDate)) {
        days.add(tempDate);
      }
    }
    days.sort((a, b) => b.compareTo(a));
    for (DateTime day in days) {
      List<Task> tempTasks = tasks
          .where((task) =>
              task.createDate.year == day.year &&
              task.createDate.month == day.month &&
              task.createDate.day == day.day)
          .toList();
      createDateMapList
          .add({DateTimeFunctions().dateTimeToTextDate(date: day): tempTasks});
    }
    return createDateMapList;
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
}
