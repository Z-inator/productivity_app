import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Task_Feature/services/tasks_data.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:provider/provider.dart';

class ProjectAssociatedTasks extends StatelessWidget {
  final String projectName;
  ProjectAssociatedTasks({this.projectName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
                          // TODO: begin work on this page
      )     
    );
  }
}
