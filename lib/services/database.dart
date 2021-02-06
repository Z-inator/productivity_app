import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productivity_app/models/projects.dart';

class DatabaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  // Build new user collections
  Future<void> buildUser(String uid, String firstName, String lastName) async {
    await userCollection.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'statuses': ['To Do', 'In Progress', 'Done']
    });
  }
}

// // Reduce repetition method for items
// Future<void> addItem(Map data, String type) async {
//   return await userCollection
//       .doc(uid)
//       .collection(type)
//       .add(data)
//       .then((value) => print('$type Added'))
//       .catchError((error) => print('Failed to add $type: $error'));
// }

//   // Get Project collection reference
//   CollectionReference _getProjectsReference() {
//     final CollectionReference projectCollection = FirebaseFirestore.instance
//         .collection('users')
//         .doc(uid)
//         .collection('projects');
//     return projectCollection;
//   }

//   // Add Project to projects
//   Future<void> addProject(String projectName, String projectColor) async {
//     await userCollection
//         .doc(uid)
//         .collection('projects')
//         .add({'projectName': projectName, 'projectColor': projectColor})
//         .then((value) => print('Project Added'))
//         .catchError((error) => print('Failed to add project: $error'));
//   }

//   // Update Project
//   Future<void> updateProject(
//       String projectID, String projectName, String projectColor) async {
//     final CollectionReference projectCollection = _getProjectsReference();
//     return await projectCollection
//         .doc(projectID)
//         .set({'projectName': projectName, 'projectColor': projectColor});
//   }

//   // Project Model from snapshot
//   Projects _projectModelFromSnapshot(DocumentSnapshot snapshot) {
//     Map<String, dynamic> data = snapshot.data();
//     return Projects(
//         projectID: data['uid'],
//         projectName: data['projectName'],
//         projectColor: data['projectColor']);
//   }

//   // Project list from snapshot
//   List<Projects> _projectListFromSnapshot(QuerySnapshot snapshot) {
//     return snapshot.docs.map((doc) {
//       return Projects(
//         projectID: doc['projectID'] ?? '',
//         projectName: doc['projectName'] ?? '',
//         projectColor: doc['projectColor'] ?? '',
//       );
//     }).toList();
//   }

//   // Get Project Model stream
//   Stream<Projects> get projectModel {
//     final CollectionReference projectCollection = _getProjectsReference();
//     return projectCollection
//         .doc(Projects().projectID)
//         .snapshots()
//         .map(_projectModelFromSnapshot);
//   }

//   Stream get projectCollection {
//     final CollectionReference projectCollection = _getProjectsReference();
//     return projectCollection.snapshots();
//   }

//   // Get Project stream
//   Stream<List<Projects>> get projects {
//     final CollectionReference projectCollection = _getProjectsReference();
//     return projectCollection.snapshots().map(_projectListFromSnapshot);
//   }
// }
