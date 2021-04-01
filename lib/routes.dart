import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:productivity_app/Task_Feature/screens/project_tasks.dart';
import 'package:productivity_app/Task_Feature/services/tasks_data.dart';
import 'package:productivity_app/Shared/widgets/base_framework.dart';
import 'Home_Dashboard/screens/home_screen.dart';
import 'Time_Feature/screens/time_screen.dart';
import 'Task_Feature/screens/task_project_screen.dart';
import 'Goal_Feature/screens/goal_screen.dart';
import 'Authentification/screens/wrapper.dart';
import 'test_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => Wrapper());
    case '/homescreen':
      return MaterialPageRoute(builder: (context) => BaseFramework());
    case '/testtime':
      return MaterialPageRoute(builder: (context) => TimeScreen());
    case '/timescreen':
      return MaterialPageRoute(builder: (context) => TimeScreen());
    case '/projectscreen':
      return MaterialPageRoute(builder: (context) => TaskScreen());
    case '/taskscreen':
      var selectedProject = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => ProjectAssociatedTasks(
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
