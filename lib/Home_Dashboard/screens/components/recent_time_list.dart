import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';

import '../../../Time_Feature/Time_Feature.dart';
import '../../../Task_Feature/Task_Feature.dart';
import '../../../Shared/Shared.dart';

class RecentTimeList extends StatelessWidget {
  final List<TimeEntry>? timeEntries;
  const RecentTimeList({Key? key, this.timeEntries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MaterialColor> colorList = AppColorList;
    return Card(
        child: timeEntries == null
            ? Center(
                child: Text('No Recorded Time for the Week'),
              )
            : Container(
                margin: EdgeInsets.all(25),
                child: ListView(
                  children: timeEntries!.map((entry) {
                    return ListTile(
                      leading: IconButton(
                          icon: Icon(Icons.play_arrow_rounded),
                          onPressed: () {}),
                      title: Text(entry.entryName!),
                      subtitle: Text(
                        entry.project!.projectName!,
                        style:
                            TextStyle(color: DynamicColorTheme.of(context).isDark ? colorList[entry.project!.projectColor!].shade200 : colorList[entry.project!.projectColor!]),
                      ),
                    );
                  }).toList(),
                )));
  }
}
