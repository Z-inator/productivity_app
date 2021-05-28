import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Authentification/screens/auth_widget.dart';
import 'package:productivity_app/Authentification/screens/auth_widget_builder.dart';
import 'package:productivity_app/Authentification/services/authentification_data.dart';
import 'package:productivity_app/Theme/style.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        return DynamicColorTheme(
          data: (color, isDark) => buildThemeData(color, isDark),
          defaultColor: Colors.blue,
          defaultIsDark: false,
          themedWidgetBuilder: (context, theme) {
            return
                // GestureDetector(
                //   onTap: () {
                //     FocusScopeNode currentFocus = FocusScope.of(context);
                //     if (!currentFocus.hasPrimaryFocus) {
                //       currentFocus.unfocus();
                //       // Provider.of<AuthService>(context, listen: false).isDialOpen.value = false;
                //     }
                //   },
                //   child:
                MaterialApp(
              title: 'Productivity App',
              theme: theme,
              home: AuthWidget(userSnapshot: userSnapshot),
              // onGenerateRoute: generateRoute,
              // initialRoute: '/',
              // ),
            );
          },
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
