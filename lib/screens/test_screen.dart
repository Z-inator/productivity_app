import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/services/authentification.dart';
import 'package:productivity_app/services/database.dart';
import 'package:productivity_app/models/projects.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final projects = Provider.of<List<Projects>>(context);
    // return StreamProvider<List<Projects>>.value(
    //   value: DatabaseService().projects,
    int counter = 0;

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
                AuthService().signOut().then((value) => print(FirebaseAuth.instance.currentUser));
              },
              child: Text('Sign Out')),
          RaisedButton(
              onPressed: () {
                DatabaseService(uid: 'cNB6nEhkv0dJLhGJrvflz4P1jR33')
                    .addProject('projectName$counter', 'projectColor$counter');
                counter += 1;
              },
              child: Text('Add Project')),
          RaisedButton(
              onPressed: () {
                DatabaseService().updateProject('31afg4ei9mKnzpGTcNEp',
                    'projectNameUpdate', 'projectColorUpdate');
              },
              child: Text('Update Project')),
          RaisedButton(
              onPressed: () {
                return showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc('cNB6nEhkv0dJLhGJrvflz4P1jR33')
                              .collection('projects')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            return !snapshot.hasData
                                ? Text('Please Wait')
                                : ListView.builder(
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (BuildContext context, index) {
                                      DocumentSnapshot projects =
                                          snapshot.data.docs[index];
                                      return ListTile(
                                        title: Text(projects['projectName']),
                                        subtitle:
                                            Text(projects['projectColor']),
                                      );
                                    },
                                  );
                          });
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
