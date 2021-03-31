import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:productivity_app/models/projects.dart';
import 'package:productivity_app/models/status.dart';
import 'package:productivity_app/models/tasks.dart';
import 'package:productivity_app/screens/home/home_screen.dart';
import 'package:productivity_app/services/authentification_data.dart';
import 'package:productivity_app/services/projects_data.dart';
import 'package:productivity_app/services/statuses_data.dart';
import 'package:productivity_app/services/tasks_data.dart';
import 'package:productivity_app/shared_components/base_framework2.dart';
import 'package:provider/provider.dart';
import 'package:productivity_app/screens/test_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Project> projects = Provider.of<List<Project>>(context);
    List<Status> statuses =  Provider.of<List<Status>>(context);
    final User user = Provider.of<User>(context);
    if (user == null) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  AuthService().signInWithEmailAndPassword(
                      'zaw1593@yahoo.com', 'testing123456');
                },
                child: Text('Sign In')),
            ElevatedButton(
              onPressed: () {
                AuthService().registerWithEmailAndPassword(
                    'zaw1593@yahoo.com', 'testing123456');
              },
              child: Text('Register'),
            )
          ]);
    }
    if (!user.emailVerified) {
      user.sendEmailVerification();
      // var actionCodeSettings = ActionCodeSettings(   // TODO: add email verification redirect to app
      //   url: 'https://www.'
      // )
    }
    return StreamProvider.value(
        value: TaskService().streamTasks(projects, statuses),
        child: BaseFramework2());
  }
}
