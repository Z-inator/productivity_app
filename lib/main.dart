import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productivity_app/routes.dart';
import 'package:productivity_app/screens/home_screen.dart';
import 'package:productivity_app/screens/test_screen.dart';
import 'package:productivity_app/services/authentification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:productivity_app/services/database.dart';
import 'package:productivity_app/services/projects_data.dart';
import 'package:provider/provider.dart';
import 'package:productivity_app/models/projects.dart';

import 'theme/style.dart';
import 'screens/error_screen.dart';
import 'screens/loading_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProductivityApp());
}

class ProductivityApp extends StatelessWidget {
  // Create initialization Future outside of build:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // @override
  // Widget build(BuildContext context) {
  //   return StreamProvider<User>.value(
  //     value: AuthService().user,
  //     child: MaterialApp(
  //       home: HomeScreen(),
  //       routes: routes,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for Errors:
          if (snapshot.hasError) {
            return SomethingWentWrong();
          }
          // Once complete, show application:
          if (snapshot.connectionState == ConnectionState.done) {
            return MultiProvider(
                providers: [
                  StreamProvider<User>.value(value: AuthService().user),
                  StreamProvider.value(value: ProjectService().projectsCollection)
                ],
                child: MaterialApp(
                  title: 'ProductivityApp',
                  // theme: appTheme(),
                  home: Wrapper(),
                  routes: routes,
                ),
            );
          }
          // Show Loading screen while waiting for initialization to complete:
          return Container();
        });
  }
}

// void main() => runApp(ProductivityApp());

// class ProductivityApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         StreamProvider<User>.value(value: Authentification().user)
//       ],
//       child: MaterialApp(
//         // Firebase Analytics
//         navigatorObservers: [
//           FirebaseAnalyticsObserver(analytics: FirebaseAnalytics())
//         ],
//         routes: routes,
//       ),
//     );
//   }
// }
