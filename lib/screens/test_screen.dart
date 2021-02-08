import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/components/task_page/task_list.dart';
import 'package:productivity_app/services/authentification.dart';
import 'package:productivity_app/services/database.dart';
import 'package:productivity_app/models/projects.dart';
import 'package:productivity_app/services/projects_data.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    if (user == null) {
      return RaisedButton(
          onPressed: () {
            AuthService().signInWithEmailAndPassword(
                'someone@gmail.com', 'testing123456');
          },
          child: Text('Sign In'));
    }
    return TestScreen();
  }
}

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final projects = Provider.of<List<Projects>>(context);
    // return StreamProvider<List<Projects>>.value(
    //   value: DatabaseService().projects,
    int counter = 0;
    final user = Provider.of<User>(context);

    return Container(
        child: SafeArea(
            child: Scaffold(
      body: Column(
        children: [
          RaisedButton(
              onPressed: () {
                AuthService().signInWithEmailAndPassword(
                    'someone@gmail.com', 'testing123456');
              },
              child: Text('Sign In')),
          RaisedButton(
              onPressed: () {
                AuthService().registerWithEmailAndPassword(
                    'someone@gmail.com', 'testing123456');
              },
              child: Text('Register')),
          RaisedButton(
              onPressed: () {
                AuthService()
                    .signOut()
                    .then((value) => print(FirebaseAuth.instance.currentUser));
              },
              child: Text('Sign Out')),
          RaisedButton(
              onPressed: () {
                ProjectService()
                    .addProject('projectName$counter', 'projectColor$counter');
                counter += 1;
              },
              child: Text('Add Project')),
          RaisedButton(
              onPressed: () {
                ProjectService().updateProject('31afg4ei9mKnzpGTcNEp',
                    'projectNameUpdate', 'projectColorUpdate');
              },
              child: Text('Update Project')),
          RaisedButton(
              onPressed: () {
                return showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      CollectionReference projects = FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid)
                          .collection('projects');
                      return StreamBuilder<QuerySnapshot>(
                        stream: projects.snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          return !snapshot.hasData
                              ? Text('Please Wait')
                              : ListView(
                                  children: snapshot.data.docs
                                      .map((DocumentSnapshot document) {
                                    final String docID = document.id;
                                    print(document.id);
                                    return ListTile(
                                      leading: IconButton(
                                          icon: Icon(Icons.plus_one),
                                          onPressed: () {
                                            ProjectService().updateProject(
                                                docID,
                                                'NewprojectNameUpdate',
                                                'NewprojectColorupdate');
                                          }),
                                      title:
                                          Text(document.data()['projectName']),
                                      subtitle:
                                          Text(document.data()['projectColor']),
                                      trailing: IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                            ProjectService().deleteProject(
                                                docID);
                                          }),
                                    );
                                  }).toList(),
                                );
                        },
                      );
                    });
              },
              child: Text('Show Projects')),
        ],
      ),
    )));
    //   ),
    // );
  }
}
