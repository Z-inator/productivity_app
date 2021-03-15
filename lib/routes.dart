import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:productivity_app/screens/tasks/components/task_from_project_future.dart';
// import 'package:productivity_app/screens/tasks/test.dart';
import 'package:productivity_app/screens/tasks/test2.dart';
import 'package:productivity_app/services/tasks_data.dart';
import 'package:productivity_app/shared_components/base_framework2.dart';
import 'screens/home/home_screen.dart';
import 'screens/timeEntries/time_screen.dart';
import 'screens/tasks/task_project_screen.dart';
import 'screens/goals/goal_screen.dart';
import 'screens/authentification/wrapper.dart';
import 'screens/test_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => Wrapper());
    case '/homescreen':
      return MaterialPageRoute(builder: (context) => BaseFramework2());
    case '/timescreen':
      return MaterialPageRoute(builder: (context) => TimeScreen());
    case '/projectscreen':
      return MaterialPageRoute(builder: (context) => TaskScreen());
    case '/taskscreen':
      var selectedProject = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => AssociatedTaskStream(
                projectName: selectedProject,
              ));
    case '/functionalityscreen':
      return MaterialPageRoute(builder: (context) => TestScreen());
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

// final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
//   '/homepage': (BuildContext context) => HomeScreen(),
//   '/timepage': (BuildContext context) => TimeScreen(),
//   '/taskpage': (BuildContext context) => TaskStream(),
//   '/goalpage': (BuildContext context) => GoalScreen(),
//   '/projectContent': (BuildContext context) => ProjectContentPage(),
// };
