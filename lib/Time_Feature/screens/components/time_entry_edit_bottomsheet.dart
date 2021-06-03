import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Shared/Shared.dart';
import '../../../Task_Feature/Task_Feature.dart';
import '../../../Time_Feature/Time_Feature.dart';
import '../../../Services/database.dart';

class TimeEntryEditBottomSheet extends StatelessWidget {
  final bool isUpdate;
  final TimeEntry entry;

  TimeEntryEditBottomSheet({Key key, this.isUpdate, this.entry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MaterialColor> colorList = AppColorList;
    return ChangeNotifierProvider(
      create: (context) => TimeEntryEditState(oldEntry: entry),
      builder: (context, child) {
        final DatabaseService databaseService =
            Provider.of<DatabaseService>(context);
        final TimeEntryEditState timeEntryEditState =
            Provider.of<TimeEntryEditState>(context);
        return Container(
            margin: EdgeInsets.all(20),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextField(
                decoration: InputDecoration(
                    hintText: timeEntryEditState.newEntry.entryName.isEmpty
                        ? 'Enter Time Entry Name'
                        : timeEntryEditState.newEntry.entryName),
                textAlign: TextAlign.center,
                onChanged: (newText) {
                  timeEntryEditState.updateEntryName(newText);
                },
              ),
              ProjectPicker(
                saveProject: timeEntryEditState.updateEntryProject,
                child: ListTile(
                  leading: Icon(
                    Icons.topic_rounded,
                    color: timeEntryEditState.newEntry.project.id.isEmpty
                      ? Colors.grey
                      : DynamicColorTheme.of(context).isDark ? colorList[timeEntryEditState.newEntry.project.projectColor].shade200 : colorList[timeEntryEditState.newEntry.project.projectColor]
                  ),
                  title: Text(
                      timeEntryEditState.newEntry.project.id.isEmpty
                          ? 'Add Project'
                          : timeEntryEditState.newEntry.project.projectName,
                      style: DynamicColorTheme.of(context)
                          .data
                          .textTheme
                          .subtitle1),
                  trailing: Icon(Icons.arrow_drop_down_rounded,
                      color: DynamicColorTheme.of(context)
                          .data
                          .unselectedWidgetColor),
                ),
              ),
              TaskPicker(
                saveTask: timeEntryEditState.updateEntryTask,
                child: ListTile(
                  leading: Icon(Icons.check_circle_rounded,
                      color: timeEntryEditState.newEntry.task.id.isEmpty
                      ? Colors.grey
                      : DynamicColorTheme.of(context).isDark ? colorList[timeEntryEditState.newEntry.task.status.statusColor].shade200 : colorList[
                          timeEntryEditState.newEntry.task.status.statusColor]),
                  title: Text(timeEntryEditState.newEntry.task.id.isEmpty
                      ? 'Add Task'
                      : timeEntryEditState.newEntry.task.taskName),
                  trailing: Icon(Icons.arrow_drop_down_rounded,
                      color: DynamicColorTheme.of(context)
                          .data
                          .unselectedWidgetColor),
                ),
              ),
              ListTile(
                leading: OutlinedButton.icon(
                    onPressed: () => DateAndTimePickers().selectDate(
                        context: context,
                        initialDate: isUpdate
                            ? timeEntryEditState.newEntry.startTime
                            : DateTime.now(),
                        saveDate: timeEntryEditState.updateDate),
                    icon: Icon(Icons.today_rounded),
                    label: Text(DateTimeFunctions().dateTimeToTextDate(
                        date: timeEntryEditState.newEntry.startTime))),
                trailing: OutlinedButton.icon(
                    onPressed: () => DateAndTimePickers().buildTimeRangePicker(
                        context: context,
                        saveTimeRange: timeEntryEditState.updateStartEndTime),
                    icon: Icon(Icons.timelapse_rounded),
                    label: Text(
                        '${TimeOfDay.fromDateTime(timeEntryEditState.newEntry.startTime).format(context)} - ${TimeOfDay.fromDateTime(timeEntryEditState.newEntry.endTime).format(context)}')),
              ),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: ElevatedButton.icon(
                      icon: Icon(Icons.check_circle_outline_rounded),
                      label: Text(isUpdate ? 'Update' : 'Add'),
                      onPressed: () {
                        isUpdate
                            ? databaseService.updateItem(
                                type: 'timeEntries',
                                itemID: entry.id,
                                updateData:
                                    timeEntryEditState.newEntry.toFirestore())
                            : databaseService.addItem(
                                type: 'timeEntries',
                                addData:
                                    timeEntryEditState.newEntry.toFirestore());
                        Navigator.pop(context);
                      }))
            ]));
      },
    );
  }
}
