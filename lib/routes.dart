import 'package:flutter/widgets.dart';
import 'screens/home_screen.dart';
import 'screens/time_screen.dart';
import 'screens/task_screen.dart';
import 'screens/goal_screen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/homepage': (BuildContext context) => HomeScreen(),
  '/timepage': (BuildContext context) => TimeScreen(),
  '/taskpage': (BuildContext context) => TaskScreen(),
  '/goalpage': (BuildContext context) => GoalScreen(),
};
