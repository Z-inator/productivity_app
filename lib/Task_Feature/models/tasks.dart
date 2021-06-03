import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Task_Feature/Task_Feature.dart';

// class Task {
//   final String id;
//   final String taskName;
//   final Project project;
//   final Status status;
//   final DateTime dueDate;
//   final DateTime createDate;

//   Task(
//       {this.id,
//       this.taskName,
//       this.project,
//       this.status,
//       this.dueDate,
//       this.createDate});
  
//   Task.fromJson(Map<String, Object> data, DocumentSnapshot snapshot, Project project, Status status) 
//     : this(
//         id: snapshot.id ?? '',
//         taskName: data['taskName'] as String ?? '',
//         project: project ?? Project(),
//         status: status ?? Status(),
//         dueDate: (data['dueDate'] as Timestamp).toDate() ??
//             DateTime(0001, 01, 01, 01, 0, 0, 0, 555),
//         createDate:
//             (data['createDate'] as Timestamp).toDate() ?? DateTime.now()
//     );

//   Map<String, Object> toJson() {
//     return {
//       'taskName': taskName,
//       'project': project.id,
//       'status': status.id,
//       'dueDate': dueDate,
//       'createDate': createDate,
//     };
//   }

//   Task copyTask() {
//     return Task(
//         id: id ?? '',
//         taskName: taskName ?? '',
//         project: project ?? Project(),
//         status: status ?? Status(),
//         dueDate: dueDate ?? DateTime(0001, 01, 01, 0, 0, 0, 0, 555),
//         createDate: createDate ?? DateTime.now());
//   }
// }


class Task {
  String id;
  String taskName;
  Project project;
  Status status;
  DateTime dueDate;
  DateTime createDate;

  Task(
      {String id,
      String taskName,
      Project project,
      Status status,
      DateTime dueDate,
      DateTime createDate})
      : id = id ?? '',
        taskName = taskName ?? '',
        project = project ?? Project(),
        status = status ?? Status(),
        dueDate = dueDate ?? DateTime(0001, 01, 01, 0, 0, 0, 0, 555),
        createDate = createDate ?? DateTime.now();

  factory Task.fromFirestore(
      DocumentSnapshot snapshot, Project project, Status status) {
    final Map data = snapshot.data();
    return Task(
        id: snapshot.id ?? '',
        taskName: data['taskName'] as String ?? '',
        project: project ?? Project(),
        status: status ?? Status(),
        dueDate: (data['dueDate'] as Timestamp).toDate() ??
            DateTime(0001, 01, 01, 01, 0, 0, 0, 555),
        createDate:
            (data['createDate'] as Timestamp).toDate() ?? DateTime.now());
  }

  Map<String, dynamic> toFirestore() {
    return {
      'taskName': taskName,
      'project': project.id,
      'status': status.id,
      'dueDate': dueDate,
      'createDate': createDate,
    };
  }

  Task copyTask() {
    return Task(
        id: id ?? '',
        taskName: taskName ?? '',
        project: project ?? Project(),
        status: status ?? Status(),
        dueDate: dueDate ?? DateTime(0001, 01, 01, 0, 0, 0, 0, 555),
        createDate: createDate ?? DateTime.now());
  }
}
