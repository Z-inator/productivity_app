import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../Task_Feature/Task_Feature.dart';
import '../../../Time_Feature/Time_Feature.dart';

class ProjectService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Collection reference
  CollectionReference _getProjectReference() {
    final User user = _auth.currentUser;
    if (user.uid == null) {
      return null;
    } else {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('projects');
    }
  }

  CollectionReference get projects {
    return _getProjectReference();
  }

  // Snapshot Conversion to Project Model and Stream
  // Stream<List<Project>> streamProjects() {
  //   final CollectionReference ref = _getProjectReference();
  //   return ref.snapshots().map((querySnapshot) => querySnapshot.docs
  //       .map((queryDocument) => Project.fromFirestore(queryDocument))
  //       .toList());
  // }

  int getTaskCount(List<Task> tasks) {
    return tasks.length;
  }

  int getRecordedTime(List<TimeEntry> timeEntries) {
    int recordedTime = 0;
    timeEntries.forEach((entry) {
      recordedTime += entry.elapsedTime;
    });
    return recordedTime;
  }

  // // Add Project
  // Future<void> addProject({Map<String, dynamic> addData}) async {
  //   return _getProjectReference()
  //       .add(addData)
  //       .then((value) => print('Project Added'))
  //       .catchError((error) => print('Failed to add project: $error'));
  // }

  // // Update Project
  // Future<void> updateProject(
  //     {String projectID, Map<String, dynamic> updateData}) async {
  //   return _getProjectReference()
  //       .doc(projectID)
  //       .update(updateData)
  //       .then((value) => print('Project Updated'))
  //       .catchError((error) => print('Failed to update project: $error'));
  // }

  // // Delete Project
  // Future<void> deleteProject({String projectID}) async {
  //   return _getProjectReference()
  //       .doc(projectID)
  //       .delete()
  //       .then((value) => print('Project Deleted'))
  //       .catchError((error) => print('Failed to delete project: $error'));
  // }
}
