import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';

class Project {
  String projectID = '';
  String projectName = '';
  String projectClient = '';
  int projectColor = 4285887861;

  Project(
      {this.projectID,
      this.projectName,
      this.projectColor,
      this.projectClient});

  factory Project.fromFirestore(DocumentSnapshot snapshot) {
    final Map data = snapshot.data();
    return Project(
      projectID: snapshot.id ?? '',
      projectName: data['projectName'] as String ?? '',
      projectClient: data['projectClient'] as String ?? '',
      projectColor: (data['projectColor'] as int) ?? 4285887861,
    );
  }
}
