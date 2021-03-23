import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:productivity_app/models/projects.dart';
import 'package:productivity_app/services/authentification_data.dart';
import 'package:productivity_app/services/tasks_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


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
  Stream<List<Project>> streamProjects() {
    var ref = _getProjectReference();
    return ref.snapshots().map(
        (list) => list.docs.map((doc) => Project.fromFirestore(doc)).toList());
  }

  // Add Project
  Future<void> addProject(
      {String projectName, int projectColor, int projectTime = 0}) async {
    return _getProjectReference()
        .add({
          'projectName': projectName,
          'projectColor': projectColor,
          'projectTime': projectTime,
          'taskList': {}
        })
        .then((value) => print('Project Added'))
        .catchError((error) => print('Failed to add project: $error'));
  }
  // // Add Task to Project
  // Future<void> addTaskToProject({String projectID, String taskID, String taskName, String status='To Do',}) {

  // }

  // Update Project
  Future<void> updateProject({String projectID, Map updateData}) async {
    return _getProjectReference()
        .doc(projectID)
        .update(Map<String, dynamic>.from(updateData))
        .then((value) => print('Project Updated'))
        .catchError((error) => print('Failed to update project: $error'));
  }

  // Delete Project
  Future<void> deleteProject({String projectID}) async {
    return _getProjectReference()
        .doc(projectID)
        .delete()
        .then((value) => print('Project Deleted'))
        .catchError((error) => print('Failed to delete project: $error'));
  }

  
}


// class ProjectService {
//   final User user;
//   ProjectService({this.user});

//   // Collection reference
//   CollectionReference _getProjectReference() {
//     if (user == null) {
//       return null;
//     } else {
//       return FirebaseFirestore.instance
//           .collection('users')
//           .doc(user.uid)
//           .collection('projects');
//     }
//   }

//   CollectionReference get projects {
//     return _getProjectReference();
//   }

//   // Add Project
//   Future<void> addProject(
//       {String projectName, int projectColor, int projectTime = 0}) async {
//     return _getProjectReference()
//         .add({
//           'projectName': projectName,
//           'projectColor': projectColor,
//           'projectTime': projectTime,
//           'taskList': {}
//         })
//         .then((value) => print('Project Added'))
//         .catchError((error) => print('Failed to add project: $error'));
//   }
//   // // Add Task to Project
//   // Future<void> addTaskToProject({String projectID, String taskID, String taskName, String status='To Do',}) {

//   // }

//   // Update Project
//   Future<void> updateProject({String projectID, Map updateData}) async {
//     return _getProjectReference()
//         .doc(projectID)
//         .update(Map<String, dynamic>.from(updateData))
//         .then((value) => print('Project Updated'))
//         .catchError((error) => print('Failed to update project: $error'));
//   }

//   // Delete Project
//   Future<void> deleteProject({String projectID}) async {
//     return _getProjectReference()
//         .doc(projectID)
//         .delete()
//         .then((value) => print('Project Deleted'))
//         .catchError((error) => print('Failed to delete project: $error'));
//   }

//   // Get Project Color Number

// }


