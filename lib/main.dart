import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productivity_app/Authentification/screens/auth_widget_builder.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Theme/style.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/routes.dart';
import 'package:productivity_app/Home_Dashboard/screens/home_screen.dart';
import 'package:productivity_app/test_screen.dart';
import 'package:productivity_app/Authentification/services/authentification_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:productivity_app/Services/database.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Task_Feature/services/statuses_data.dart';
import 'package:productivity_app/Task_Feature/services/tasks_data.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:provider/provider.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Authentification/screens/auth_widget.dart';
import 'dart:io' show Platform;
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'Shared/screens/error_screen.dart';
import 'Shared/screens/loading_screen.dart';
import 'package:flutter/foundation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProductivityApp());
}

class ProductivityApp extends StatefulWidget {
  @override
  _ProductivityAppState createState() => _ProductivityAppState();
}

class _ProductivityAppState extends State<ProductivityApp> {
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      _error = true;
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return Center(child: Text('Something went wrong'));
    }
    if (!_initialized) {
      return Center(child: Text('Loading'));
    }
    return Provider(
      create: (context) => AuthService(),
      child: AuthWidgetBuilder(builder: (context, userSnapshot) {
        return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
                // Provider.of<AuthService>(context, listen: false).isDialOpen.value = false;
              }
            },
          child: MaterialApp(
            title: 'Productivity App',
            theme: appTheme(),
            home: AuthWidget(userSnapshot: userSnapshot),
            // onGenerateRoute: generateRoute,
            // initialRoute: '/',
          ),
        );
      }),
    );
  }
}

// return StreamProvider<User>.value(
//       value: AuthService().user,
//       child: MultiProvider(   // TODO: fix the issue for user to be logged in for the first time
//         providers: [
//           StreamProvider<List<Project>>.value(value: ProjectService().streamProjects()),
//           StreamProvider<List<Status>>.value(value: StatusService().streamStatuses()),
//         ],
//           child: MultiProvider(
//             providers: [
//               StreamProvider<List<Task>>(create: (context) {
//                 return TaskService().streamTasks(Provider.of<List<Project>>(context), Provider.of<List<Status>>(context));
//               }),
//               StreamProvider<List<TimeEntry>>(create: (context) {
//                 return TimeService().streamTimeEntries(Provider.of<List<Project>>(context));
//               })
//             ],
//             child:

//             MaterialApp(
//               title: 'ProductivityApp',
//               theme: appTheme(),
//               // home: Wrapper(),
//               // routes: routes,
//               onGenerateRoute: generateRoute,
//               initialRoute: '/',
//             ),
//           )

//       ),

//     );
