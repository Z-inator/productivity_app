import 'package:flutter/widgets.dart';
import 'package:productivity_app/screens/tasks/test.dart';
import 'package:productivity_app/screens/tasks/test2.dart';
import 'screens/home/home_screen.dart';
import 'screens/timeEntries/time_screen.dart';
import 'screens/tasks/task_screen.dart';
import 'screens/goals/goal_screen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/homepage': (BuildContext context) => HomeScreen(),
  '/timepage': (BuildContext context) => TimeScreen(),
  '/taskpage': (BuildContext context) => TaskScreen(),
  '/goalpage': (BuildContext context) => GoalScreen(),
  '/projectContent': (BuildContext context) => ProjectContentPage()
};
