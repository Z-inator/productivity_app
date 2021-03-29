import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productivity_app/models/status.dart';
import 'package:productivity_app/routes.dart';
import 'package:productivity_app/screens/home/home_screen.dart';
import 'package:productivity_app/screens/test_screen.dart';
import 'package:productivity_app/services/authentification_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:productivity_app/services/database.dart';
import 'package:productivity_app/services/projects_data.dart';
import 'package:productivity_app/services/statuses_data.dart';
import 'package:productivity_app/services/tasks_data.dart';
import 'package:provider/provider.dart';
import 'package:productivity_app/models/projects.dart';
import 'package:productivity_app/screens/authentification/wrapper.dart';
import 'dart:io' show Platform;
import 'package:productivity_app/models/tasks.dart';
import 'theme/style.dart';
import 'shared_components/error_screen.dart';
import 'shared_components/loading_screen.dart';
import 'package:flutter/foundation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProductivityApp());
}

class ProductivityApp extends StatefulWidget {
  @override
  _ProductivityAppState createState() => _ProductivityAppState();
}

class _ProductivityAppState extends State<ProductivityApp> {
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      _error = true;
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return Center(child: Text('Something went wrong'));
    }
    if (!_initialized) {
      return Center(child: Text('Loading'));
    }
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MultiProvider(   // TODO: fix the issue for user to be logged in for the first time
        providers: [
          StreamProvider<List<Project>>.value(value: ProjectService().streamProjects()),
          StreamProvider<List<Task>>.value(value: TaskService().streamTasks(context)),
          StreamProvider<List<Status>>.value(value: StatusService().streamStatuses())
        ],
          child: MaterialApp(
            title: 'ProductivityApp',
            theme: appTheme(),
            // home: Wrapper(),
            // routes: routes,
            onGenerateRoute: generateRoute,
            initialRoute: '/',
          ),
      ),

    );
  }
}
