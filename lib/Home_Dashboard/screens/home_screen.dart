import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:productivity_app/Authentification/services/authentification_data.dart';
import 'package:productivity_app/Home_Dashboard/screens/components/status_tile.dart';
import 'package:productivity_app/Home_Dashboard/screens/components/task_row.dart';
import 'package:productivity_app/Home_Dashboard/screens/components/time_chart_row.dart';
import 'package:productivity_app/Home_Dashboard/services/charts_and_graphs.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/screens/base_framework.dart';
import 'package:productivity_app/Task_Feature/screens/status_edit_page.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    User user = auth.user;
    return MultiProvider(
      providers: [
        Provider(create: (context) => TimeGraphs()),
        Provider(create: (context) => TaskCharts())
      ],
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  ListTile(
                      leading: Icon(Icons.account_circle_rounded),
                      title: Text(user.displayName),
                      subtitle: Text(DateTimeFunctions()
                          .dateTimeToTextDate(date: DateTime.now())),
                      trailing: IconButton(
                        icon: Icon(Icons.settings_rounded),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      )),
                  Text(
                      'The secret of your future is hidden in your daily routine.',
                      textAlign: TextAlign.center,
                      style: DynamicColorTheme.of(context).data
                          .textTheme
                          .subtitle1
                          .copyWith(fontStyle: FontStyle.italic)),
                  Text('Mike Murdock',
                      textAlign: TextAlign.center,
                      style: DynamicColorTheme.of(context).data.textTheme.subtitle2)
                ],
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height / 1.5,
                child: TimeChartRow()),
            Container(
                height: MediaQuery.of(context).size.height / 1.5,
                child: TaskDueRow()),
            StatusList(),
            SizedBox(height: 100)
          ],
        ),
      ),
    );
  }
}
