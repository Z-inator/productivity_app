import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/services/projects_data.dart';
import 'package:productivity_app/services/statuses_data.dart';
import 'package:productivity_app/services/times_data.dart';
import 'package:productivity_app/shared_components/color_functions.dart';
import 'package:productivity_app/shared_components/datetime_functions.dart';
import 'package:productivity_app/shared_components/time_functions.dart';
import 'package:provider/provider.dart';

class TaskStatusesFuture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return FutureBuilder(
        future: StatusService(user: user).statuses.get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading');
          }
          return ListView(
            padding: EdgeInsets.only(bottom: 100),
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              String statusName = document.data()['statusName'].toString();
              return ListTile(
                title: Text(statusName),
              );
            }).toList(),
          );
        });
  }
}
