import 'dart:js';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productivity_app/routes.dart';
import 'package:productivity_app/screens/home_screen.dart';
import 'package:productivity_app/services/authentification.dart';
import 'package:provider/provider.dart';
import 'theme/style.dart';
import 'screens/error_screen.dart';
import 'screens/loading_screen.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(ChangeNotifierProvider(
//     create: (context) => Authentification(),
//     child: ProductivityApp(),
//   ));
// }

// class ProductivityApp extends StatelessWidget {
//   // Create initialization Future outside of build:
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp();

//   @override
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
//             return MaterialApp(
//               title: 'ProductivityApp',
//               // theme: appTheme(),
//               home: HomeScreen(),
//               routes: routes,
//             );
//           }
//           // Show Loading screen while waiting for initialization to complete:
//           return Loading();
//         });
//   }
// }

void main() => runApp(ProductivityApp());

class ProductivityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<Report>.value(value: Global.reportRef.documentStream),
        StreamProvider<FirebaseUser>.value(value: AuthService().user)
      ],
      child: MaterialApp(
        // Firebase Analytics
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics())
        ],
        routes: routes,
      ),
    );
  }
}
