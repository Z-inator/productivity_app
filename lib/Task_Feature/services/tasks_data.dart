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
