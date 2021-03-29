import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productivity_app/shared_components/color_functions.dart';

class Project {
  String projectID;
  String projectName;
  String projectClient;
  int projectColor = 4285887861;
  int projectTime = 0;
  // List<String> taskList = [];

  Project(
      {this.projectID,
      this.projectName,
      this.projectColor,
      this.projectClient,
      this.projectTime});

  factory Project.fromFirestore(DocumentSnapshot snapshot) {
    Map data = snapshot.data();

    return Project(
        projectID: snapshot.id ?? '',
        projectName: data['projectName'].toString() ?? '',
        projectClient: data['projectClient'].toString() ?? '',
        projectColor: data['projectColor'] ?? 4285887861,
        projectTime: data['projectTime'] ?? 0);
  }
}
