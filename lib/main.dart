import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productivity_app/screens/home_screen.dart';
import 'package:productivity_app/screens/task_screen.dart';
import 'package:productivity_app/screens/time_screen.dart';
import 'package:productivity_app/screens/goal_screen.dart';
import 'package:productivity_app/widgets/home_page/task_tile_list_builder.dart';
import 'package:productivity_app/widgets/time_page/time_log_list.dart';
import 'package:provider/provider.dart';
import 'package:productivity_app/screens/base_framework.dart';
import 'package:productivity_app/models/data.dart';
import 'package:productivity_app/widgets/home_page/home_page_dashboard.dart';

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
      home: HomeScreen(),
      routes: <String, WidgetBuilder>{
        '/homepage': (BuildContext context) => HomeScreen(),
        '/timepage': (BuildContext context) => TimeScreen(),
        '/taskpage': (BuildContext context) => TaskScreen(),
        '/goalpage': (BuildContext context) => GoalScreen(),
      },
    );
  }
}
