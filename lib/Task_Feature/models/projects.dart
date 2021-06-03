import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  String id;
  String projectName;
  String projectClient;
  int projectColor;

  Project({id, projectName, projectColor, projectClient})
      : id = id as String? ?? '',
        projectName = projectName as String? ?? '',
        projectColor = projectColor as int? ?? 4285887861,
        projectClient = projectClient as String? ?? '';

  factory Project.fromFirestore(Map<String, Object> data, DocumentSnapshot snapshot) {
    // final Map data = snapshot.data();
    return Project(
      id: snapshot.id,
      projectName: data['projectName'] as String? ?? '',
      projectClient: data['projectClient'] as String? ?? '',
      projectColor: data['projectColor'] as int? ?? 4285887861,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'projectName': projectName,
      'projectClient': projectClient,
      'projectColor': projectColor
    };
  }

  Project copyProject() {
    return Project(
      id: id ?? '',
      projectName: projectName ?? '',
      projectClient: projectClient ?? '',
      projectColor: projectColor ?? 4285887861,
    );
  }
}
