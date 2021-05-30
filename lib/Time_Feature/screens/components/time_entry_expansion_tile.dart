import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:productivity_app/Services/database.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/providers/stopwatch_state.dart';
import 'package:productivity_app/Shared/widgets/edit_bottom_sheets.dart';
import 'package:productivity_app/Task_Feature/screens/project_page.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/screens/components/time_entry_edit_bottomsheet.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:provider/provider.dart';

class TimeEntryExpansionTile extends StatelessWidget {
  final TimeEntry entry;
  const TimeEntryExpansionTile({Key key, this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MaterialColor> colorList = AppColors().colorList;
    final DatabaseService databaseService =
        Provider.of<DatabaseService>(context);
    TimeService timeService = Provider.of<TimeService>(context);
    return ExpansionTile(
      leading: Tooltip(
        message: entry.task.status.statusName,
        child: Icon(Icons.check_circle_rounded,
            color: colorList[entry.task.status.statusColor]),
      ),
      title: Text(
        entry.entryName,
        style: DynamicColorTheme.of(context).data.textTheme.subtitle2,
      ),
      subtitle: Text(entry.project.projectName,
          style: DynamicColorTheme.of(context)
              .data
              .textTheme
              .subtitle1
              .copyWith(color: colorList[entry.project.projectColor])),
      trailing: Text(DateTimeFunctions().timeToText(seconds: entry.elapsedTime),
          style: DynamicColorTheme.of(context).data.textTheme.subtitle2),
      children: [
        Theme(
          data: DynamicColorTheme.of(context)
              .data
              .copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.play_arrow_rounded),
                  tooltip: 'Start Timer',
                  onPressed: () =>
                      Provider.of<StopwatchState>(context, listen: false)
                          .startStopwatch(oldEntry: entry),
                ),
                IconButton(
                  icon: Icon(Icons.delete_rounded),
                  tooltip: 'Delete Time Entry',
                  onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Delete Time Entry: ${entry.entryName}?'),
                          content: ListTile(
                            title: Text(
                                'This will permanently delete this time entry.\nIt will remove this recorded time from projects and tasks.'),
                          ),
                          actions: [
                            OutlinedButton.icon(
                              icon: Icon(Icons.cancel_rounded),
                              label: Text('Cancel'),
                              onPressed: () => Navigator.pop(context),
                            ),
                            ElevatedButton.icon(
                                icon: Icon(Icons.check_circle_outline_rounded),
                                label: Text('Delete'),
                                onPressed: () {
                                  databaseService.deleteItem(
                                      type: 'timeEntries', itemID: entry.id);
                                  Navigator.pop(context);
                                })
                          ],
                        );
                      }),
                ),
                IconButton(
                  icon: Icon(Icons.edit_rounded),
                  tooltip: 'Edit Time Entry',
                  onPressed: () => EditBottomSheet().buildEditBottomSheet(
                      context: context,
                      bottomSheet: TimeEntryEditBottomSheet(
                          isUpdate: true, entry: entry)),
                ),
              ],
            ),
            children: [
              ListTile(
                leading: OutlinedButton.icon(
                  style: DynamicColorTheme.of(context)
                      .data
                      .outlinedButtonTheme
                      .style,
                  icon: Icon(Icons.topic_rounded,
                      color: colorList[entry.project.projectColor]),
                  label: Text(entry.project.projectName,
                      style: DynamicColorTheme.of(context)
                          .data
                          .textTheme
                          .subtitle2),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return ProjectPage(project: entry.project);
                      }),
                    );
                  },
                ),
                trailing: Text(
                    '${DateFormat.jm().format(entry.startTime)} - ${DateFormat.jm().format(entry.endTime)}',
                    style:
                        DynamicColorTheme.of(context).data.textTheme.subtitle1),
              ),
            ],
          ),
        )
      ],
    );
  }
}
