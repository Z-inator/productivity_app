import 'package:productivity_app/services/projects_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        projectName: map['projectName'],
        projectTime: map['projectTime'],
        projectColor: map['projectColor'],
      );
    }
  }
  
}
