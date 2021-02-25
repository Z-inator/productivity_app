import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:productivity_app/models/colors.dart';
import 'package:productivity_app/shared_components/time_to_text.dart';
import 'package:productivity_app/services/projects_data.dart';
import 'package:productivity_app/services/tasks_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productivity_app/shared_components/date_to_text.dart';
import 'package:provider/provider.dart';

class ProjectContentEx extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
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
            children: snapshot.data.docs.map((DocumentSnapshot document) async{
          final String projectName = document.data()['projectName'].toString();
          final Color projectColor = await ProjectColors(colorSelector: int.parse(document.data()['projectColor'].toString())).getColor();   // TODO: Color function is not working, figure out how to properly use async & futures?
          return ListTile(
            leading: Icon(
              Icons.circle,
              color: projectColor,
            ),
            title: Text(projectName),
            subtitle: Text(document.data()['projectTime'].toString()),
          );
        }).toList());
      },
    );
  }
}
