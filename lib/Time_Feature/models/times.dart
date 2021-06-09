import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../Task_Feature/Task_Feature.dart';

class TimeEntry {
  String? id;
  DateTime? startTime;
  DateTime? endTime;
  int elapsedTime;
  String? entryName;
  Project? project;
  Task? task;

  TimeEntry(
      {this.id,
      this.entryName,
      this.project,
      this.task,
      this.startTime,
      this.endTime,
      this.elapsedTime = 0});

  TimeEntry.fromJson(Map<String, Object?> data, DocumentSnapshot snapshot,
      Project? project, Task? task)
      : this(
            id: snapshot.id,
            entryName: data['entryName']! as String,
            project: project,
            task: task,
            startTime: (data['startTime']! as Timestamp).toDate(),
            endTime: (data['endTime']! as Timestamp).toDate(),
            elapsedTime: (data['endTime']! as Timestamp).toDate()
                .difference((data['startTime']! as Timestamp).toDate())
                .inSeconds);

  Map<String, Object?> toJson() {
    return {
      'entryName': entryName,
      'project': project?.id,
      'task': task?.id,
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  TimeEntry copyTimeEntry() {
    return TimeEntry(
        id: id,
        entryName: entryName,
        project: project,
        task: task,
        startTime: startTime,
        endTime: endTime,
        elapsedTime: elapsedTime);
  }
}


// class TimeEntry {
//   String id;
//   DateTime startTime;
//   DateTime endTime;
//   int elapsedTime;
//   String entryName;
//   Project project;
//   Task task;

//   TimeEntry({id, entryName, project, task, startTime, endTime, elapsedTime})
//       : id = id as String?,
//         entryName = entryName as String?,
//         project = project as Project? ?? Project(),
//         task = task as Task? ?? Task(),
//         startTime = startTime as DateTime? ?? DateTime.now(),
//         endTime = endTime as DateTime? ?? DateTime.now().add(Duration(hours: 1)),
//         elapsedTime = elapsedTime as int? ?? 0;

//   factory TimeEntry.fromFirestore(
//     DocumentSnapshot snapshot,
//     Project project,
//     Task task
//   ) {
//     final Map data = Map.from(snapshot.data() as Map<String, Object>);
//     return TimeEntry(
//         id: snapshot.id,
//         entryName: data['entryName'] as String?,
//         project: project ?? Project(),
//         task: task ?? Task(),
//         startTime: (data['startTime'] as Timestamp).toDate() ?? DateTime.now(),
//         endTime: (data['endTime'] as Timestamp).toDate() ?? DateTime.now().add(Duration(hours: 1)),
//         elapsedTime: (data['endTime'] as Timestamp).toDate()
//             .difference((data['startTime'] as Timestamp).toDate()).inSeconds ??
//             0);
//   }

//   Map<String, dynamic> toFirestore() {
//     return {
//       'entryName': entryName,
//       'project': project.id,
//       'task': task.id,
//       'startTime': startTime,
//       'endTime': endTime,
//     };
//   }

//   TimeEntry copyTimeEntry() {
//     return TimeEntry(
//         id: id,
//         entryName: entryName,
//         project: project ?? Project(),
//         task: task ?? Task(),
//         startTime: startTime ?? DateTime.now(),
//         endTime: endTime ?? DateTime.now().add(Duration(hours: 1)),
//         elapsedTime: elapsedTime ?? 0);
//   }
// }
