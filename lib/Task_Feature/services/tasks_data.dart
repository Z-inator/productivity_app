import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Time_Feature/Time_Feature.dart';
import '../../../Task_Feature/Task_Feature.dart';
import '../../../Shared/Shared.dart';

class TaskService {
  /// Current thought:
  /// Let the stream be a query and have a list listen to the query. The query can update the list.
  /// I can use Provider and ChangeNotifier to listen to the stream and stop listening when User logs out.
  /// The listen() method may allow me to convert the collection to a list.
  /// This may also allow me to shrink the number of providers that I have.
  /// Put this functionality inside of AuthWidgetBuilder.

  // CollectionReference<Task> taskReference(List<Project> projects, List<Status> statuses) {
  //   return FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection('tasks')
  //       .withConverter<Task>(
  //         fromFirestore: (DocumentSnapshot<Map<String, dynamic>> snapshot, _) =>
  //             Task.fromJson(snapshot.data()!, snapshot, getProject(projects, snapshot.data()!['project'] as String), getStatus(statuses, snapshot.data()!['status'] as String)),
  //         toFirestore: (task, _) => task.toJson(),
  //       );
  // }

  // Project? getProject(List<Project> projects, String? projectID) {
  //   if (projectID == null) {
  //     return null;
  //   }
  //   return projects.singleWhere((project) => project.id == projectID);
  // }

  // Status? getStatus(List<Status> statuses, String? statusID) {
  //   if (statusID == null) {
  //     return null;
  //   }
  //   return statuses.singleWhere((status) => status.id == statusID);
  // }

  // Stream<List<Task>> streamTasks(List<Project> projects, List<Status> statuses) {
  //   taskReference.snapshots().listen((snapshot) {
  //     List<Task> tasks = [];
  //     snapshot.docs.forEach((QueryDocumentSnapshot<Task> queryDocumentSnapshot) {
  //       tasks.add(queryDocumentSnapshot.data());
  //     });
  //   });
  //   return tasks;
  // }

  // Future<QuerySnapshot<List<Task>>> taskFromSnapshot(List<Project> projects, List<Status> statuses) {
  //   return taskReference(projects, statuses).snapshot
  // }

  // List<Task> taskListFromSnapshot(Query snapshot) {
  //   return snapshot..docs.map((QueryDocumentSnapshot queryDocumentSnapshot) => queryDocumentSnapshot.).toList();
  // }

  // Snapshot Conversion to Task Model and Stream
  // Stream<List<Task>>? streamTasks(BuildContext context) {
  //   List<Project> projects;
  //   getProjects(context).then((projectList) => projects = projectList);
  //   List<Status> statuses;
  //   getStatuses(context).then((statusList) => statuses = statusList);
  //   tasks.snapshots()
  //   return tasks.snapshots().map((QuerySnapshot querySnapshot) =>
  //       querySnapshot.docs.map((QueryDocumentSnapshot queryDocument) {
  //         final Project project = projects.firstWhere((project) =>
  //             project.id == queryDocument.data()['project'].toString());
  //         final Status status = statuses.firstWhere((status) =>
  //             status.id == queryDocument.data()['status'].toString());
  //         return Task.fromFirestore(queryDocument, project, status);
  //       }).toList());
  // }

  // Future<List<Project>> getProjects(BuildContext context) async {
  //   final List<Project> projects =
  //       await Provider.of<ProjectService>(context).streamProjects().first;
  //   return projects;
  // }

  // Future<List<Status>> getStatuses(BuildContext context) async {
  //   final List<Status> statuses =
  //       await Provider.of<StatusService>(context).streamStatuses().first;
  //   return statuses;
  // }

  static List<Map<Status, List<Task>>> getTasksByStatus(
      List<Task> tasks, List<Status> statuses) {
    statuses.sort((a, b) => a.statusOrder!.compareTo(b.statusOrder!));
    List<Map<Status, List<Task>>> statusMapList = [];
    List<Task> noStatusTasks = [];
    for (Status status in statuses) {
      List<Task> tempTasks =
          tasks.where((task) => task.status?.id == status.id).toList();
      statusMapList.add({status: tempTasks});
    }
    noStatusTasks.addAll(tasks.where((task) => task.status == null));
    if (noStatusTasks.isNotEmpty) {
      statusMapList.add({Status(statusName: 'No Status'): noStatusTasks});
    }
    return statusMapList;
  }

  static List<Map<Project, List<Task>>> getTasksByProject(
      List<Task> tasks, List<Project> projects) {
    List<Map<Project, List<Task>>> projectMapList = [];
    List<Task> noProjectTasks = [];
    for (Project project in projects) {
      List<Task> tempTasks =
          tasks.where((task) => task.project?.id == project.id).toList();
      projectMapList.add({project: tempTasks});
    }
    noProjectTasks.addAll(tasks.where((task) => task.project == null));
    if (noProjectTasks.isNotEmpty) {
      projectMapList.add({Project(projectName: 'No Project'): noProjectTasks});
    }
    return projectMapList;
  }

  static List<Map<String, List<Task>>> getTasksByDueDate(List<Task> tasks) {
    List<Map<String, List<Task>>> dueDateMapList = [];
    List<Task> noDueDateTasks = [];
    List<DateTime> days = [];
    for (Task task in tasks) {
      if (task.dueDate == null) {
        continue;
      }
      DateTime? tempDate =
          DateTime(task.dueDate!.year, task.dueDate!.month, task.dueDate!.day);
      if (!days.contains(tempDate)) {
        days.add(tempDate);
      }
    }
    days.sort((a, b) => a.compareTo(b));
    for (DateTime day in days) {
      List<Task> tempTasks = tasks
          .where((task) =>
              task.dueDate?.year == day.year &&
              task.dueDate?.month == day.month &&
              task.dueDate?.day == day.day)
          .toList();
      dueDateMapList
          .add({DateTimeFunctions().dateTimeToTextDate(date: day)!: tempTasks});
    }
    noDueDateTasks.addAll(tasks.where((task) => task.dueDate == null));
    if (noDueDateTasks.isNotEmpty) {
      dueDateMapList.add({'No Due Date': noDueDateTasks});
    }
    return dueDateMapList;
  }

  static List<Map<String, List<Task>>> getTasksByCreateDate(List<Task> tasks) {
    List<Map<String, List<Task>>> createDateMapList = [];
    List<DateTime> days = [];
    for (Task task in tasks) {
      if (task.createDate == null || task.createDate == null) {
        continue;
      }
      DateTime? tempDate = DateTime(
          task.createDate!.year, task.createDate!.month, task.createDate!.day);
      if (!days.contains(tempDate)) {
        days.add(tempDate);
      }
    }
    days.sort((a, b) => b.compareTo(a));
    for (DateTime day in days) {
      List<Task> tempTasks = tasks
          .where((task) =>
              task.createDate?.year == day.year &&
              task.createDate?.month == day.month &&
              task.createDate?.day == day.day)
          .toList();
      createDateMapList
          .add({DateTimeFunctions().dateTimeToTextDate(date: day)!: tempTasks});
    }
    return createDateMapList;
  }

  static int getSubtaskCount(List<Subtask> subtasks, Task task) {
    return subtasks.length;
  }

  static int getRecordedTime(List<TimeEntry> timeEntries, Task task) {
    int recordedTime = 0;
    timeEntries.forEach((entry) {
      recordedTime += entry.elapsedTime;
    });
    return recordedTime;
  }
}
