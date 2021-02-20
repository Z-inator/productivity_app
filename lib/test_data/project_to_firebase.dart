import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productivity_app/services/projects_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:productivity_app/services/tasks_data.dart';

class ProjectToFirebase {
  User user;
  ProjectToFirebase({this.user});

  List<Map<String, dynamic>> projectData = [
    {"projectTime": 421, "projectName": "Linkbridge", "projectColor": 1},
    {"projectTime": 469, "projectName": "Thoughtsphere", "projectColor": 4},
    {"projectTime": 45, "projectName": "Topicblab", "projectColor": 1},
    {"projectTime": 97, "projectName": "Skimia", "projectColor": 1},
    {"projectTime": 390, "projectName": "Aimbu", "projectColor": 1},
    {"projectTime": 126, "projectName": "Oyondu", "projectColor": 4},
    {"projectTime": 7, "projectName": "Plambee", "projectColor": 10},
    {"projectTime": 434, "projectName": "Avamm", "projectColor": 10},
    {"projectTime": 37, "projectName": "Skiba", "projectColor": 10},
    {"projectTime": 228, "projectName": "Skyble", "projectColor": 10},
  ];

  Future<void> uploadExampleData() {
    for (Map<String, dynamic> map in projectData) {
      ProjectService(user: user).addProject(
        projectName: map['projectName'].toString(),
        projectTime: map['projectTime'],
        projectColor: map['projectColor'],
      );
    }
  }

  Future<void> updateProjectData() async {
    Map<String, String> projects = {};
    await ProjectService(user: user)
        .projects
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                projects[doc.id] = doc['projectName'].toString();
              })
            });
    projects.forEach((key, value) async {
      Map<String, String> taskInfo = {};
      await TaskService(user: user)
          .tasks
          .where('projectName', isEqualTo: value)
          .get()
          .then((QuerySnapshot querySnapshot) => {
                querySnapshot.docs.forEach((doc) {
                  taskInfo[doc.id] = doc['taskName'].toString();
                  print(
                      'projectID: $key projectname: $value ----- taskID: ${doc.id} name: ${doc['taskName']}');
                })
              });
      ProjectService(user: user).updateProject(projectID: key, updateData: {
        'taskList': Map.from(taskInfo)
      }).then((value) => print('project updated'));
    });
  }
}
