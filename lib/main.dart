import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productivity_app/routes.dart';
import 'package:productivity_app/screens/home_screen.dart';
import 'routes.dart';
import 'theme/style.dart';

void main() => runApp(ProductivityApp());

class ProductivityApp extends StatelessWidget {
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[50],
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProductivityApp',
      // theme: appTheme(),
      home: HomeScreen(),
      routes: routes,
    );
  }
}
