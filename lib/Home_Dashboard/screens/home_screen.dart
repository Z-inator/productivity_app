import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../../Authentification/Authentification.dart';
import '../../../Home_Dashboard/Home_Dashboard.dart';
import '../../../Shared/Shared.dart';

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
    ThemeData themeData = DynamicColorTheme.of(context).data;
    AuthService auth = Provider.of<AuthService>(context);
    User user = auth.user!;
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
                      leading: Icon(Icons.account_circle_rounded,
                          color: themeData.iconTheme.color),
                      title: Text(user.displayName!,
                          style: themeData
                              .textTheme
                              .headline5),
                      subtitle: Text(
                          DateTimeFunctions()
                              .dateTimeToTextDate(date: DateTime.now())!,
                          style: themeData
                              .textTheme
                              .bodyText2),
                      trailing: IconButton(
                        icon: Icon(Icons.settings_rounded),
                        color:
                            themeData.iconTheme.color,
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      )),
                  Text(
                      'The secret of your future is hidden in your daily routine.',
                      textAlign: TextAlign.center,
                      style: themeData
                          .textTheme
                          .subtitle2!
                          .copyWith(fontStyle: FontStyle.italic)),
                  Text('Mike Murdock',
                      textAlign: TextAlign.center,
                      style: themeData
                          .textTheme
                          .subtitle1)
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
