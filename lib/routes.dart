import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Authentification/screens/auth_widget.dart';
import 'Shared/screens/base_framework.dart';
import 'Task_Feature/models/projects.dart';
import 'Task_Feature/screens/project_page.dart';
import 'Task_Feature/screens/task_project_screen.dart';
import 'Time_Feature/screens/time_screen.dart';
import 'test_screen.dart';

// Route<dynamic> generateRoute(RouteSettings settings) {
//   switch (settings.name) {
//     case '/':
//       return MaterialPageRoute(builder: (context) => AuthWidget());
//     case '/homescreen':
//       return MaterialPageRoute(builder: (context) => BaseFramework());
//     case '/testtime':
//       return MaterialPageRoute(builder: (context) => TimeScreen());
//     case '/timescreen':
//       return MaterialPageRoute(builder: (context) => TimeScreen());
//     case '/taskscreen':
//       return MaterialPageRoute(builder: (context) => TaskProjectScreen());
//     case '/projectscreen':
//       final Project? selectedProject = settings.arguments as Project?;
//       return MaterialPageRoute(
//           builder: (context) => ProjectPage(
//                 project: selectedProject,
//               ));
//     case '/functionalityscreen':
//       return MaterialPageRoute(builder: (context) => TestScreen());
//     default:
//       return MaterialPageRoute(
//           builder: (_) => Scaffold(
//                 body: Center(
//                     child: Text('No route defined for ${settings.name}')),
//               ));
//   }
// }

// final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
//   '/homepage': (BuildContext context) => HomeScreen(),
//   '/timepage': (BuildContext context) => TimeScreen(),
//   '/taskpage': (BuildContext context) => TaskStream(),
//   '/goalpage': (BuildContext context) => GoalScreen(),
//   '/projectContent': (BuildContext context) => ProjectContentPage(),
// };
