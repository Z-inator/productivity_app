import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Shared/Shared.dart';
import '../../../Task_Feature/Task_Feature.dart';
import '../../../Time_Feature/Time_Feature.dart';
import '../../../Services/database.dart';

class TaskExpansionTile extends StatelessWidget {
  final Task task;
  const TaskExpansionTile({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MaterialColor> colorList = AppColorList;
    final DatabaseService databaseService =
        Provider.of<DatabaseService>(context);
    List<TimeEntry> timeEntries = TimeService.getTimeEntriesByTask(
        Provider.of<List<TimeEntry>>(context), task);
    int recordedTime = TaskService.getRecordedTime(timeEntries, task);
    // int subtaskCount = 0; // TODO: implement Subtasks
    return ExpansionTile(
      leading: Tooltip(
        message: task.status?.statusName ?? 'NO STATUS',
        child: Icon(Icons.check_circle_rounded,
            color: task.status != null
                ? DynamicColorTheme.of(context).isDark
                    ? colorList[task.status!.statusColor!].shade200
                    : colorList[task.status!.statusColor!]
                : Colors.grey),
      ),
      title: Text(task.taskName ?? 'NO TASK TITLE'),
      subtitle: Text(task.project?.projectName ?? 'NO PROJECT',
          style: DynamicColorTheme.of(context)
              .data
              .textTheme
              .subtitle1!
              .copyWith(
                  color: task.project != null
                  ? DynamicColorTheme.of(context).isDark
                      ? colorList[task.project!.projectColor!].shade200
                      : colorList[task.project!.projectColor!]
                  : Colors.grey)),
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
                    onPressed: () => Provider.of<StopwatchState>(context,
                            listen: false)
                        .startStopwatch(
                            oldEntry:
                                TimeEntry(task: task, project: task.project)),
                  ),
                  IconButton(
                      icon: Icon(Icons.timelapse_rounded),
                      tooltip: 'Add Time Entry',
                      onPressed: () => EditBottomSheet().buildEditBottomSheet(
                          context: context,
                          bottomSheet: TimeEntryEditBottomSheet(
                              isUpdate: false,
                              entry: TimeEntry(
                                  task: task, project: task.project)))),
                  // IconButton(
                  //   icon: Icon(Icons.add_rounded),
                  //   tooltip: 'Add Subtask',
                  //   onPressed: () {},
                  // ),
                  // IconButton(
                  //   icon: Icon(Icons.alarm_rounded),
                  //   tooltip: 'Edit Due Date',
                  //   onPressed: () {},
                  // ),
                  IconButton(
                    icon: Icon(Icons.delete_rounded),
                    tooltip: 'Delete Task',
                    onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Delete Task: ${task.taskName}?'),
                            content: ListTile(
                              title: Text(
                                  'This will permanently delete this task.\nIt will not delete related time entries or projects.'),
                            ),
                            actions: [
                              OutlinedButton.icon(
                                icon: Icon(Icons.cancel_rounded),
                                label: Text('Cancel'),
                                onPressed: () => Navigator.pop(context),
                              ),
                              ElevatedButton.icon(
                                  icon:
                                      Icon(Icons.check_circle_outline_rounded),
                                  label: Text('Delete'),
                                  onPressed: () {
                                    databaseService.deleteItem(
                                        collectionReference:
                                            databaseService.taskReference!,
                                        objectID: task.id!);
                                    Navigator.pop(context);
                                  })
                            ],
                          );
                        }),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit_rounded),
                    tooltip: 'Edit Task',
                    onPressed: () => EditBottomSheet().buildEditBottomSheet(
                        context: context,
                        bottomSheet:
                            TaskEditBottomSheet(isUpdate: true, task: task)),
                  ),
                  StatusPickerDropDown(
                    task: task,
                    icon: Icon(Icons.done_rounded),
                  )
                ]),
            children: [
              ListTile(
                dense: true,
                leading: RichText(
                  text: TextSpan(
                    text: 'Project: ',
                    style: DynamicColorTheme.of(context).data.textTheme.subtitle1,
                    children: [
                      TextSpan(
                        text: task.project?.projectName ?? 'NO PROJECT',
                        style: DynamicColorTheme.of(context).data.textTheme.subtitle1?.copyWith(
                          color: task.project != null
                            ? DynamicColorTheme.of(context).isDark
                                ? colorList[task.project!.projectColor!].shade200
                                : colorList[task.project!.projectColor!]
                            : Colors.grey),
                      )
                    ]
                  )
                ),
                trailing: RichText(
                    text: TextSpan(
                        text: 'Status: ',
                        style: DynamicColorTheme.of(context)
                            .data
                            .textTheme
                            .subtitle1,
                        children: <TextSpan>[
                      TextSpan(
                          text: task.status?.statusName,
                          style: DynamicColorTheme.of(context)
                              .data
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  color: task.status != null
                                      ? DynamicColorTheme.of(context).isDark
                                          ? colorList[task.status!.statusColor!].shade200
                                          : colorList[task.status!.statusColor!]
                                      : Colors.grey))
                    ])),
              ),
              ListTile(
                dense: true,
                // leading: Text('Subtasks: $subtaskCount',
                //     style: DynamicColorTheme.of(context).data.textTheme.subtitle1),
                leading: Text(
                    'Recorded Time: ${DateTimeFunctions().timeToText(seconds: recordedTime)}',
                    style:
                        DynamicColorTheme.of(context).data.textTheme.subtitle2),
              ),
              ListTile(
                dense: true,
                leading: Text(
                        'Due: ${DateTimeFunctions().dateTimeToTextDate(date: task.dueDate) ?? ''}',
                        style: DynamicColorTheme.of(context).data.textTheme.subtitle2),
                trailing: Text(
                    DateTimeFunctions().dateTimeToTextTime(date: task.dueTime, context: context) ?? '',
                    style: DynamicColorTheme.of(context).data.textTheme.subtitle2),
              ),
              Text(
                  'Created: ${DateTimeFunctions().dateTimeToTextDate(date: task.createDate)}',
                  style: DynamicColorTheme.of(context).data.textTheme.caption),
            ],
          ),
        )
      ],
    );
  }
}
