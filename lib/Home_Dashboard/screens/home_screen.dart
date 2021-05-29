import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:productivity_app/Authentification/services/authentification_data.dart';
import 'package:productivity_app/Home_Dashboard/screens/components/status_tile.dart';
import 'package:productivity_app/Home_Dashboard/screens/components/task_row.dart';
import 'package:productivity_app/Home_Dashboard/screens/components/time_chart_row.dart';
import 'package:productivity_app/Home_Dashboard/services/charts_and_graphs.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of<AuthService>(context);
    final User user = auth.user;
    return MultiProvider(
      providers: [
        Provider(create: (context) => TimeGraphs()),
        Provider(create: (context) => TaskCharts())
      ],
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  ListTile(
                      leading: Icon(Icons.account_circle_rounded,
                          color:
                              DynamicTheme.of(context).theme.iconTheme.color),
                      title: Text(user.displayName,
                          style: DynamicTheme.of(context)
                              .theme
                              .textTheme
                              .headline5),
                      subtitle: Text(
                          DateTimeFunctions()
                              .dateTimeToTextDate(date: DateTime.now()),
                          style: DynamicTheme.of(context)
                              .theme
                              .textTheme
                              .bodyText2),
                      trailing: IconButton(
                        icon: Icon(Icons.settings_rounded),
                        color: DynamicTheme.of(context).theme.iconTheme.color,
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      )),
                  Text(
                      'The secret of your future is hidden in your daily routine.',
                      textAlign: TextAlign.center,
                      style: DynamicTheme.of(context)
                          .theme
                          .textTheme
                          .subtitle2
                          .copyWith(fontStyle: FontStyle.italic)),
                  Text('Mike Murdock',
                      textAlign: TextAlign.center,
                      style: DynamicTheme.of(context).theme.textTheme.subtitle1)
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
