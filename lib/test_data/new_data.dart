//Colors: 4294937216, 4292149248, 4287954944, 4292886779, 4289331455, 4279903102, 4280902399, 4282434815, 4279828479, 4280150454, 4278241363, 4279983648, 4285988611, 4294951936, 4294938880, 4294917376, 4288776319, 4283315246, 4285887861, 4284513675

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Task_Feature/services/statuses_data.dart';
import 'package:productivity_app/Task_Feature/services/tasks_data.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'new_mock_data.dart' as mock;

class NewDataUpload {
  List<Map<String, dynamic>> projectData = mock.projectData;

  List<Map<String, dynamic>> statusData = mock.statusData;

  List<Map<String, dynamic>> taskData = mock.taskData;

  dynamic uploadExampleProjectData() {
    for (Map<String, dynamic> map in projectData) {
      ProjectService().addProject(addData: {
        'projectName': map['projectName'] as String,
        'projectColor': map['projectColor'] as int
      });
    }
  }

  dynamic uploadExampleStatusData() {
    for (Map<String, dynamic> map in statusData) {
      StatusService().addStatus(addData: {
        'statusName': map['statusName'] as String,
        'statusColor': map['statusColor'] as int,
        'statusOrder': map['statusOrder'] as int,
        'equalToComplete': map['equalToComplete'] as bool
      });
    }
  }

  dynamic uploadExampleTaskData() {
    for (Map<String, dynamic> map in taskData) {
      TaskService().addTask(addData: {
        'taskName': map['taskName'] as String,
        'project': map['project'] as String,
        'status': map['status'] as String,
        'dueDate': DateTime.parse(map['dueDate'].toString()),
        'createDate': DateTime.parse(map['createDate'].toString())
      });
    }
  }

  // Future uploadExampleTimeData() async {
  //   for (Map<String, dynamic> map in taskData) {
  //     QuerySnapshot taskDoc = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc('GCuVCCMfwNeKWjPXceUViDgQKxW2')
  //         .collection('tasks')
  //         .where('taskName', isEqualTo: map['taskName'])
  //         .get();
  //     String id = taskDoc.docs.first.id;
  //     TimeService().addTimeEntry(addData: {
  //       'entryName': map['taskName'] as String,
  //       'project': map['project'] as String,
  //       'task': id as String,
  //       'startTime': DateTime(2021, 6, 20, 7, 30),
  //       'endTime': DateTime(2021, 6, 20, 8, 30),
  //     });
  //   }
  // }

  dynamic uploadExampleTimeData(List<Task> tasks) {
    int count = 5;
    for (Task task in tasks) {
      switch (count.remainder(5).toInt()) {
        case 0:
          TimeService().addTimeEntry(addData: {
            'entryName': task.taskName as String,
            'project': task.project.id as String,
            'task': task.id as String,
            'startTime': DateTime(2021, 5, 3, 7, 30),
            'endTime': DateTime(2021, 5, 3, 8, 30),
          });
          break;
        case 1:
          TimeService().addTimeEntry(addData: {
            'entryName': task.taskName as String,
            'project': task.project.id as String,
            'task': task.id as String,
            'startTime': DateTime(2021, 5, 4, 7, 30),
            'endTime': DateTime(2021, 5, 4, 8, 30),
          });
          break;
          case 2:
            TimeService().addTimeEntry(addData: {
              'entryName': task.taskName as String,
              'project': task.project.id as String,
              'task': task.id as String,
              'startTime': DateTime(2021, 5, 5, 7, 30),
              'endTime': DateTime(2021, 5, 5, 8, 30),
            });
          break;
          case 3:
            TimeService().addTimeEntry(addData: {
              'entryName': task.taskName as String,
              'project': task.project.id as String,
              'task': task.id as String,
              'startTime': DateTime(2021, 5, 6, 7, 30),
              'endTime': DateTime(2021, 5, 6, 8, 30),
            });
          break;
          case 4:
            TimeService().addTimeEntry(addData: {
              'entryName': task.taskName as String,
              'project': task.project.id as String,
              'task': task.id as String,
              'startTime': DateTime(2021, 5, 7, 7, 30),
              'endTime': DateTime(2021, 5, 7, 8, 30),
            });
          break;
        default:
          TimeService().addTimeEntry(addData: {
            'entryName': task.taskName as String,
            'project': task.project.id as String,
            'task': task.id as String,
            'startTime': DateTime(2021, 5, 8, 7, 30),
            'endTime': DateTime(2021, 5, 8, 8, 30),
          });
      }
      count++;
    }
  }
}
