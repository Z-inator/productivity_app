import 'package:flutter/material.dart';
import 'package:productivity_app/Authentification/services/authentification_data.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Task_Feature/services/statuses_data.dart';
import 'package:productivity_app/Task_Feature/services/tasks_data.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:productivity_app/Users/models/user_model.dart';
import 'package:provider/provider.dart';

/// Used to create user-dependant objects that need to be accessible by all widgets.
/// This widget should live above the [MaterialApp].
/// See [AuthWidget], a descendant widget that consumes the snapshot generated by this builder.

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({Key key, @required this.builder}) : super(key: key);
  final Widget Function(BuildContext, AsyncSnapshot<UserModel>) builder;

  @override
  Widget build(BuildContext context) {
    print('AuthWidgetBuilder rebuild');
    final authService = Provider.of<AuthService>(context, listen: false);
    return StreamBuilder<UserModel>(
      stream: authService.onAuthStateChanged,
      builder: (context, snapshot) {
        print('StreamBuilder: ${snapshot.connectionState}');
        final UserModel user = snapshot.data;
        if (user != null) {
          return MultiProvider(
            providers: [
              Provider<UserModel>.value(value: user),
              Provider(create: (context) => ProjectService()),
              Provider(create: (context) => StatusService()),
              Provider(create: (context) => TaskService()),
              Provider(create: (context) => TimeService()),
            ],
            builder: (context, child) {
              return MultiProvider(
                providers: [
                  StreamProvider<List<Project>>.value(
                      value: Provider.of<ProjectService>(context)
                          .streamProjects()),
                  StreamProvider<List<Status>>.value(
                      value: Provider.of<StatusService>(context)
                          .streamStatuses()),
                  StreamProvider<List<Task>>.value(
                      value: Provider.of<TaskService>(context)
                          .streamTasks(context)),
                  StreamProvider<List<TimeEntry>>.value(
                      value: Provider.of<TimeService>(context)
                          .streamTimeEntries(context))
                ],
                child: builder(context, snapshot),
              );
            },
            child: builder(context, snapshot),
          );
        }
        return builder(context, snapshot);
      },
    );
  }
}