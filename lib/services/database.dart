import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productivity_app/models/projects.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // Collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  // Build new user collections
  Future<void> buildUser(String firstName, String lastName) async {
    await userCollection.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'statuses': ['To Do', 'In Progress', 'Done']
    });
  }

  /*////////////////////////////////////////////////////////////////////////////

        Section: Projects

  /////////////////////////////////////////////////////////////////////////// */

  // Add Project to projects
  Future<void> addProject(String projectName, String projectColor) async {
    await userCollection
        .doc(uid)
        .collection('projects')
        .add({'projectName': projectName, 'projectColor': projectColor})
        .then((value) => print('Project Added'))
        .catchError((error) => print('Failed to add project: $error'));
  }

  // Get Project collection reference
  CollectionReference _getProjectsReference() {
    final CollectionReference projectCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('projects');
    return projectCollection;
  }

  // Project list from snapshot
  List<Projects> _projectListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Projects(
        projectName: doc['projectName'] ?? '',
        projectColor: doc['projectColor'] ?? '',
      );
    }).toList();
  }

  // Get Project stream
  Stream<List<Projects>> get projects {
    final CollectionReference projectCollection = _getProjectsReference();
    return projectCollection.snapshots().map(_projectListFromSnapshot);
  }
}


  /*////////////////////////////////////////////////////////////////////////////

        Section: Tasks

  /////////////////////////////////////////////////////////////////////////// */




  /*////////////////////////////////////////////////////////////////////////////

        Section: Subtasks

  /////////////////////////////////////////////////////////////////////////// */




  /*////////////////////////////////////////////////////////////////////////////

        Section: Goals

  /////////////////////////////////////////////////////////////////////////// */




  /*////////////////////////////////////////////////////////////////////////////

        Section: Habits

  /////////////////////////////////////////////////////////////////////////// */




  /*////////////////////////////////////////////////////////////////////////////

        Section: Statuses

  /////////////////////////////////////////////////////////////////////////// */




  /*////////////////////////////////////////////////////////////////////////////

        Section: Times

  /////////////////////////////////////////////////////////////////////////// */