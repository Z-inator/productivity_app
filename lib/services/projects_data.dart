import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/models/projects.dart';
import 'package:productivity_app/services/globals.dart';

class ProjectService {
  // Collection reference
  CollectionReference _getProjectReference() {
    if (Global().user == null) {
      return null;
    } else {
      return FirebaseFirestore.instance
          .collection(Global().userCollection.toString())
          .doc(Global().user.uid)
          .collection('projects');
    }
  }

  CollectionReference get projects {
    return _getProjectReference();
  }

  // Add Project
  Future<void> addProject({String projectName='', int projectColor=0, int projectTime=0}) async {
    return await _getProjectReference()
        .add({'projectName': projectName, 'projectColor': projectColor, 'projectTime': projectTime, 'taskList': []})
        .then((value) => print('Project Added'))
        .catchError((error) => print('Failed to add project: $error'));
  }
  // // Add Task to Project
  // Future<void> addTaskToProject({String projectID, String taskID, String taskName, String status='To Do',}) {

  // }

  // Update Project
  Future<void> updateProject(
      {String projectID, String projectName='', int projectColor=0}) async {
    return await _getProjectReference()
        .doc(projectID)
        .update({'projectName': projectName, 'projectColor': projectColor});
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


class ProjectsStream extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: ProjectService().projects.snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        }
        return ListView(
                children: snapshot.data.docs
                    .map((DocumentSnapshot document) {
                  final String docID = document.id;
                  print(document.id);
                  return ListTile(
                    leading: IconButton(
                        icon: Icon(Icons.plus_one),
                        onPressed: () {
                          ProjectService().updateProject(
                              projectID: docID,
                              projectName: 'NewprojectNameUpdate',
                              projectColor: 0);
                        }),
                    title:
                        Text(document.data()['projectName']),
                    subtitle:
                        Text(document.data()['projectColor']),
                    trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          ProjectService().deleteProject(
                              projectID: docID);
                        }),
                  );
                }).toList(),
              );
      },
    );
  }
}


// Project Collections Stream
// Stream<QuerySnapshot> get projects {
//   return _getProjectReference().snapshots();
// }

// Projects _projectModelFromSnapshot(DocumentSnapshot snapshot) {
//   Map<String, dynamic> data = snapshot.data();
//   return Projects(
//       projectID: data['uid'],
//       projectName: data['projectName'],
//       projectColor: data['projectColor']);
// }

// // Project list from snapshot
// List<Projects> _projectListFromSnapshot(QuerySnapshot snapshot) {
//   return snapshot.docs.map((doc) {
//     return Projects(
//         projectID: doc.data()['projectID'] ?? '',
//         projectName: doc.data()['projectName'] ?? '',
//         projectColor: doc.data()['projectColor'] ?? '');
//   }).toList();
// }

// Stream<List<Projects>> get projects {
//   final CollectionReference projects = _getProjectReference();
//   return projects.snapshots().map(_projectListFromSnapshot);
// }

class AddProject extends StatelessWidget {
  final String projectName;
  final String projectColor;
  final int projectTime = 0;

  AddProject({this.projectName, this.projectColor});

  @override
  Widget build(BuildContext context) {
    CollectionReference project =
        FirebaseFirestore.instance.collection('projects');

    Future<void> addProject() {
      return project
          .add({
            'projectName': projectName,
            'projectColor': projectColor,
            'projectTime': projectTime
          })
          .then((value) => print('Project Added'))
          .catchError((error) => print('Failed to add project: $error'));
    }

    return FlatButton(onPressed: addProject, child: Text('Add Project'));
  }
}

class UpdateProject extends StatelessWidget {
  final String documentReference;
  final String projectName;
  final String projectColor;
  final int projectTime;

  UpdateProject(
      {this.documentReference,
      this.projectName,
      this.projectColor,
      this.projectTime});

  @override
  Widget build(BuildContext context) {
    CollectionReference project =
        FirebaseFirestore.instance.collection('projects');

    Future<void> updateProject() {
      return project
          .doc(documentReference)
          .update({
            'projectName': projectName,
            'projectColor': projectColor,
            'projectTime': projectTime
          })
          .then((value) => print('Project Updated'))
          .catchError((error) => print("Failed to update user: $error"));
    }

    return FlatButton(onPressed: updateProject, child: Text('Update Project'));
  }
}

class DeleteProject extends StatelessWidget {
  final String documentReference;

  DeleteProject({this.documentReference});

  @override
  Widget build(BuildContext context) {
    CollectionReference project =
        FirebaseFirestore.instance.collection('projects');

    Future<void> deleteProject() {
      return project
          .doc(documentReference)
          .delete()
          .then((value) => print('Project Deleted'))
          .catchError((error) => print('Failed to delete project: $error'));
    }

    // Future<void> deleteField() {
    //   return project
    //     .doc(documentReference)
    //     .delete()
    //     .then((value) => print('Project Deleted'))
    //     .catchError((error) => print('Failed to delete project: $error'));
    // }

    return FlatButton(onPressed: deleteProject, child: Text('Delete Project'));
  }
}

class ProjectStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference projects =
        FirebaseFirestore.instance.collection('projects');

    return StreamBuilder<QuerySnapshot>(
        stream: projects.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading');
          }
          return new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return new ListTile(
                title: new Text(document.data()['projectName']),
                subtitle: new Text(document.data()['projectTime'].toString()),
              );
            }).toList(),
          );
        });
  }
}
