import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../Shared/Shared.dart';
import '../../../Task_Feature/Task_Feature.dart';
import '../../../Time_Feature/Time_Feature.dart';
import '../../../Services/database.dart';

class TimeEntryExpansionTile extends StatelessWidget {
  final TimeEntry entry;
  const TimeEntryExpansionTile({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MaterialColor> colorList = AppColorList;
    ThemeData themeData = DynamicColorTheme.of(context).data;
    final DatabaseService databaseService =
        Provider.of<DatabaseService>(context);
    return ExpansionTile(
      leading: Tooltip(
        message: entry.task?.status?.statusName ?? 'No Task',
        child: Icon(Icons.check_circle_rounded,
            color: entry.task != null
            ? DynamicColorTheme.of(context).isDark
                ? colorList[entry.task!.status!.statusColor!].shade200
                : colorList[entry.task!.status!.statusColor!]
            : Colors.grey),
      ),
      title: Text(
        entry.entryName!,
      ),
      subtitle: Text(entry.project?.projectName ?? 'NO PROJECT',
          style: themeData
              .textTheme
              .subtitle1!
              .copyWith(
                  color: entry.project != null
                    ? DynamicColorTheme.of(context).isDark
                      ? colorList[entry.project!.projectColor!].shade200
                      : colorList[entry.project!.projectColor!]
                    : Colors.grey)),
      trailing: Text(DateTimeFunctions().timeToText(seconds: entry.elapsedTime),
          style: themeData.textTheme.subtitle2),
      children: [
        Theme(
          data: themeData
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
                                      collectionReference: databaseService.timeEntryReference!, objectID: entry.id!);
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
                dense: true,
                leading: RichText(
                  text: TextSpan(
                    text: 'Project: ',
                    style: themeData.textTheme.subtitle1,
                    children: [
                      TextSpan(
                        text: entry.project?.projectName ?? 'NO PROJECT',
                        style: themeData.textTheme.subtitle1?.copyWith(
                          color: entry.project != null
                            ? DynamicColorTheme.of(context).isDark
                                ? colorList[entry.project!.projectColor!].shade200
                                : colorList[entry.project!.projectColor!]
                            : Colors.grey),
                      )
                    ]
                  )
                ),
                trailing: Text(
                    '${DateFormat.jm().format(entry.startTime!)} - ${DateFormat.jm().format(entry.endTime!)}',
                    style:
                        themeData.textTheme.subtitle1),
              ),
            ],
          ),
        )
      ],
    );
  }
}
