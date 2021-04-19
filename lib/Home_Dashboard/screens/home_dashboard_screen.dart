import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Home_Dashboard/screens/components/status_tile.dart';
import 'package:productivity_app/Home_Dashboard/screens/components/task_row.dart';
import 'package:productivity_app/Home_Dashboard/screens/components/time_chart_row.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/screens/components/status_expansion_tile.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_expansion_tile.dart';
import 'package:productivity_app/Task_Feature/screens/status_edit_page.dart';
import 'package:productivity_app/Task_Feature/services/statuses_data.dart';
import 'package:productivity_app/Task_Feature/services/tasks_data.dart';
import 'package:provider/provider.dart';

class HomeDashBoard extends StatelessWidget {
  const HomeDashBoard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                    leading: CircleAvatar(
                      foregroundImage: NetworkImage(
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                    ),
                    title: Text('Butt Face'),
                    subtitle: Text(DateTimeFunctions()
                        .dateTimeToTextDate(date: DateTime.now())),
                    trailing: IconButton(
                      icon: Icon(Icons.settings_rounded),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    )),
                Text(
                    'The secret of your future is hidden in your daily routine.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontStyle: FontStyle.italic)),
                Text('Mike Murdock',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1)
              ],
            ),
          ),
          ListTile(
            title: Text('Recorded Time',
                style: Theme.of(context).textTheme.headline5),
            // trailing: IconButton(
            //   icon: Icon(Icons.insights_rounded),
            //   tooltip: 'Reports',
            //   onPressed: () {},
            // ),
          ),
          Container(
              height: MediaQuery.of(context).size.height / 2,
              child: TimeChartRow()),
          ListTile(
            title: Text('Important Tasks',
                style: Theme.of(context).textTheme.headline5),
            // trailing: IconButton(
            //   icon: Icon(Icons.insights_rounded),
            //   tooltip: 'Reports',
            //   onPressed: () {},
            // ),
          ),
          Container(
              height: MediaQuery.of(context).size.height / 2,
              child: TaskDueRow()),
          ListTile(
            title:
                Text('Statuses', style: Theme.of(context).textTheme.headline5),
            trailing: IconButton(
              icon: Icon(Icons.edit_rounded),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StatusEditPage(),
                    ));
              },
            ),
          ),
          StatusList(),
          SizedBox(height: 100)
        ],
      ),
    );
  }
}
