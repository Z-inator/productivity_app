import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProjectService {
  final user;
  ProjectService({this.user});

  // Collection reference
  CollectionReference _getProjectReference() {
    if (user == null) {
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

  // Add Project
  Future<void> addProject(
      {String projectName,
      int projectColor,
      int projectTime = 0}) async {
    return await _getProjectReference()
        .add({
          'projectName': projectName,
          'projectColor': projectColor,
          'projectTime': projectTime,
          'taskList': []
        })
        .then((value) => print('Project Added'))
        .catchError((error) => print('Failed to add project: $error'));
  }
  // // Add Task to Project
  // Future<void> addTaskToProject({String projectID, String taskID, String taskName, String status='To Do',}) {

  // }

  // Update Project
  Future<void> updateProject(
      {String projectID, String projectName, int projectColor}) async {
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
  final user;
  ProjectsStream({this.user});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: ProjectService(user: user).projects.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        }
        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            final String docID = document.id;
            print(document.id);
            return ListTile(
              leading: IconButton(
                  icon: Icon(Icons.plus_one),
                  onPressed: () {
                    ProjectService(user: user).updateProject(
                        projectID: docID,
                        projectName: 'NewprojectNameUpdate',
                        projectColor: 0);
                  }),
              title: Text(document.data()['projectName']),
              subtitle: Text(document.data()['projectColor']),
              trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    ProjectService(user: user).deleteProject(projectID: docID);
                  }),
            );
          }).toList(),
        );
      },
    );
  }
}
