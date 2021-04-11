import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';

class Project {
  String projectID;
  String projectName;
  String projectClient;
  int projectColor;

  Project({projectID, projectName, projectColor = 4285887861, projectClient})
      : projectID = projectID as String ?? '',
        projectName = projectName as String ?? '',
        projectColor = projectColor as int ?? 4285887861,
        projectClient = projectClient as String ?? '';

  factory Project.fromFirestore(DocumentSnapshot snapshot) {
    final Map data = snapshot.data();
    return Project(
      projectID: snapshot.id ?? '',
      projectName: data['projectName'] as String ?? '',
      projectClient: data['projectClient'] as String ?? '',
      projectColor: data['projectColor'] as int ?? 4285887861,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'projectName': projectName,
      'projectClient': projectClient,
      'projectColor': projectColor
    };
  }
}
