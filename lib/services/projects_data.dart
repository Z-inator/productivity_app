import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:productivity_app/services/tasks_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProjectService {
  final User user;
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

class ProjectsStream extends StatefulWidget {
  ProjectsStream({Key key}) : super(key: key);

  @override
  _ProjectsStreamState createState() => _ProjectsStreamState();
}

class _ProjectsStreamState extends State<ProjectsStream> {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    bool isExpanded = true;
    return StreamBuilder<QuerySnapshot>(
      stream: ProjectService(user: user).projects.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> projectSnapshot) {
        if (projectSnapshot.hasError) {
          return Text('Something went wrong');
        }
        if (projectSnapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        }
        return SingleChildScrollView(
          child: Container(
            child: ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              children: projectSnapshot.data.docs.map((DocumentSnapshot document) {
                final String docID = document.id;
                return ExpansionPanel(
                  isExpanded: isExpanded,   // TODO: Fix expanded issue, everything else is working.
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(document.data()['projectName'].toString()),
                      subtitle: Text(document.data()['projectTime'].toString()),
                    );
                  },
                  body: StreamBuilder(
                    stream: TaskService(user: user).tasks.where('projectName', isEqualTo: document.data()['projectName']).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> taskSnapshot) {
                      if (taskSnapshot.hasError) {
                        return Text('Something went wrong');
                      }
                      if (taskSnapshot.connectionState == ConnectionState.waiting) {
                        return Text('Loading');
                      }
                      return ListView(
                        shrinkWrap: true,
                        children: taskSnapshot.data.docs.map((DocumentSnapshot taskDocument) {
                          final String docID = taskDocument.id;
                          return ListTile(
                            leading: IconButton(
                              icon: Icon(Icons.play_arrow_rounded), 
                              onPressed: () {}
                            ),
                            title: Text(taskDocument.data()['taskName'].toString()),
                            subtitle: Text(taskDocument.data()['dueDate'].toString()),
                            trailing: IconButton(
                              icon: Icon(Icons.edit_rounded),
                              onPressed: () {},
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

