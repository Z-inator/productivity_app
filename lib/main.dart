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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  String host = defaultTargetPlatform == TargetPlatform.android
      ? '10.0.2.2:8000'
      : 'localhost:8080';
  FirebaseFirestore.instance.settings = Settings(host: host, sslEnabled: false);

  // await FirebaseFirestore.instance
  //     .settings(
  //         host: host,
  //         sslEnabled: false,
  //         persistenceEnabled: false,
  //         timestampsInSnapshotsEnabled: true)
  //     .catchError((e) => print(e));

  runApp(ProductivityApp());

  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FirebaseFunctions.instance
  //     .useFunctionsEmulator(origin: 'http://localhost:5001');
  // runApp(ProductivityApp());
}

class ProductivityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'ProductivityApp',
        // theme: appTheme(),
        home: Wrapper(),
        routes: routes,
      ),
    );
  }
}

// @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         // Initialize FlutterFire:
//         future: _initialization,
//         builder: (context, snapshot) {
//           // Check for Errors:
//           if (snapshot.hasError) {
//             return SomethingWentWrong();
//           }
//           // Once complete, show application:
//           if (snapshot.connectionState == ConnectionState.done) {
//             return StreamProvider<User>.value(
//               value: AuthService().user,
//               child: MaterialApp(
//                 title: 'ProductivityApp',
//                 // theme: appTheme(),
//                 home: Wrapper(),
//                 routes: routes,
//               ),
//             );
//           }
//           // Show Loading screen while waiting for initialization to complete:
//           return Container();
//         });
//   }
// }
