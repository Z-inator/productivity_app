import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productivity_app/routes.dart';
import 'package:productivity_app/screens/home_screen.dart';
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
            return MaterialApp(
              title: 'ProductivityApp',
              // theme: appTheme(),
              home: HomeScreen(),
              routes: routes,
            );
          }
          // Show Loading screen while waiting for initialization to complete:
          return Loading();
        });
  }
}
