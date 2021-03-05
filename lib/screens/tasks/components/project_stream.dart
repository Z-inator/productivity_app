import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/services/projects_data.dart';
import 'package:productivity_app/shared_components/color_functions.dart';
import 'package:productivity_app/shared_components/time_functions.dart';
import 'package:provider/provider.dart';


class ProjectStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    return StreamBuilder<QuerySnapshot>(
        stream: ProjectService(user: user).projects.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text('Loading'));
          }
          return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
            final String docID = document.id;
            final String projectName =
                document.data()['projectName'].toString();
            final Color projectColor = ProjectColors().getColor(
                colorNumber:
                    int.parse(document.data()['projectColor'].toString()));
            final String elapsedTime = TimeFunctions().timeToText(
                seconds: int.parse(document.data()['projectTime'].toString()));
            return ListTile(
                leading: Icon(
                  Icons.circle,
                  color: projectColor,
                ),
                title: Text(projectName),
                subtitle: Text(elapsedTime),
                trailing: IconButton(
                    icon: Icon(Icons.playlist_add_rounded),
                    onPressed: () {
                      Navigator.pushNamed(context, '/taskscreen',
                          arguments: projectName);
                    }));
          }).toList());
        });
  }
}