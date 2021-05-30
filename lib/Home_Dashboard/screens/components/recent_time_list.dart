import 'package:flutter/material.dart';
import 'package:productivity_app/Home_Dashboard/services/charts_and_graphs.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/screens/components/time_entries_list.dart';
import 'package:provider/provider.dart';

class RecentTimeList extends StatelessWidget {
  final List<TimeEntry> timeEntries;
  const RecentTimeList({Key key, this.timeEntries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MaterialColor> colorList = AppColors().colorList;
    return Card(
        child: timeEntries == null
            ? Center(
                child: Text('No Recorded Time for the Week'),
              )
            : Container(
                margin: EdgeInsets.all(25),
                child: ListView(
                  children: timeEntries.map((entry) {
                    return ListTile(
                      leading: IconButton(
                          icon: Icon(Icons.play_arrow_rounded),
                          onPressed: () {}),
                      title: Text(entry.entryName),
                      subtitle: Text(
                        entry.project.projectName,
                        style:
                            TextStyle(color: colorList[entry.project.projectColor]),
                      ),
                    );
                  }).toList(),
                )));
  }
}
