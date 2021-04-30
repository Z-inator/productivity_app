import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:productivity_app/Shared/widgets/date_and_time_pickers.dart';
import 'package:productivity_app/Shared/widgets/edit_bottom_sheets.dart';
import 'package:productivity_app/Task_Feature/screens/project_page.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/screens/components/time_entry_edit_bottomsheet.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TimeEntryExpansionTile extends StatelessWidget {
  final TimeEntry entry;
  const TimeEntryExpansionTile({Key key, this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimeService timeService = Provider.of<TimeService>(context);
    return ExpansionTile(
      leading: IconButton(
          icon: Icon(Icons.topic_rounded),
          color: Color(entry.project.projectColor),
          onPressed: () {}),
      title: Text(entry.entryName),
      subtitle: Text(entry.project.projectName,
          style: TextStyle(color: Color(entry.project.projectColor))),
      trailing: Text(TimeFunctions().timeToText(seconds: entry.elapsedTime)),
      children: [
        Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    icon: Icon(Icons.play_arrow_rounded),
                    tooltip: 'Start Timer',
                    onPressed: () {},
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
                                    timeService.deleteTimeEntry(timeEntryID: entry.entryID);
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
                        bottomSheet:
                            TimeEntryEditBottomSheet(isUpdate: true, entry: entry)),
                  ),
              ],
            ),
            children: [
              ListTile(
                title: Text(DateTimeFunctions().dateTimeToTextDate(date: entry.endTime)),
                trailing: Text('${DateFormat.jm().format(entry.startTime)} - ${DateFormat.jm().format(entry.endTime)}', style: Theme.of(context).textTheme.subtitle1),
              ),
              ListTile(
                leading: OutlinedButton.icon(
                  style: Theme.of(context).outlinedButtonTheme.style,
                  icon: Icon(Icons.topic_rounded, color: Color(entry.project.projectColor)),
                  label: Text(entry.project.projectName, style: Theme.of(context).textTheme.subtitle1),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return ProjectPage(project: entry.project);
                      }),
                    );
                  },
                ),
                // trailing: Text('Task Status: ${entry.task.taskName}'),
              ),
              
            ],
          ),
        )
      ],
    );
  }
}
