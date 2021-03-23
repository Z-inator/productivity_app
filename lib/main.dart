import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productivity_app/routes.dart';
import 'package:productivity_app/screens/home/home_screen.dart';
import 'package:productivity_app/screens/test_screen.dart';
import 'package:productivity_app/services/authentification_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:productivity_app/services/database.dart';
import 'package:productivity_app/services/projects_data.dart';
import 'package:provider/provider.dart';
import 'package:productivity_app/models/projects.dart';
import 'package:productivity_app/screens/authentification/wrapper.dart';
import 'dart:io' show Platform;
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
      // String host = defaultTargetPlatform == TargetPlatform.android
      //     ? '10.0.2.2:8000'
      //     : 'localHost:8080';
      // FirebaseFirestore.instance.settings =
      //     Settings(host: host, sslEnabled: false);
      // FirebaseAuth.instance.useEmulator('http://localhost:9099');
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
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(value: AuthService().user),
        StreamProvider<List<Project>>.value(value: ProjectService().streamProjects())
      ],
      child: MaterialApp(
        title: 'ProductivityApp',
        theme: appTheme(),
        // home: Wrapper(),
        // routes: routes,
        onGenerateRoute: generateRoute,
        initialRoute: '/',
      ),

    );
  }
}
