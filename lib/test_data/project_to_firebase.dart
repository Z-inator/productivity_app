import 'package:productivity_app/services/projects_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProjectToFirebase {
  User user;
  ProjectToFirebase({this.user});

  List<Map<String, dynamic>> projectData = [];

  Future<void> uploadExampleData() {
    for (Map<String, dynamic> map in projectData) {
      ProjectService(user: user).addProject(
        
      )
    }
  }
}
