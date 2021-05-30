import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Services/database.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/providers/stopwatch_state.dart';
import 'package:productivity_app/Shared/widgets/edit_bottom_sheets.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/screens/components/status_picker.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/project_page.dart';
import 'package:productivity_app/Task_Feature/services/tasks_data.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/screens/components/time_entry_edit_bottomsheet.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:provider/provider.dart';

class TaskExpansionTile extends StatelessWidget {
  final Task task;
  const TaskExpansionTile({Key key, this.task});

  @override
  Widget build(BuildContext context) {
    List<MaterialColor> colorList = AppColors().colorList;
    final DatabaseService databaseService =
        Provider.of<DatabaseService>(context);
    final TaskService taskService = Provider.of<TaskService>(context);
    final TimeService timeService = Provider.of<TimeService>(context);
    List<TimeEntry> timeEntries = timeService.getTimeEntriesByTask(
        Provider.of<List<TimeEntry>>(context), task);
    int recordedTime = taskService.getRecordedTime(timeEntries, task);
    // int subtaskCount = 0; // TODO: implement Subtasks
    return ExpansionTile(
      leading: Tooltip(
        message: task.status.statusName,
        child: Icon(Icons.check_circle_rounded,
            color: colorList[task.status.statusColor]),
      ),
      title: Text(
        task.taskName.isEmpty ? 'NO TASK TITLE' : task.taskName,
        style: DynamicColorTheme.of(context).data.textTheme.subtitle2,
      ),
      subtitle: Text(
          task.project.id.isEmpty ? 'NO PROJECT' : task.project.projectName,
          style: DynamicColorTheme.of(context)
              .data
              .textTheme
              .subtitle1
              .copyWith(color: colorList[task.project.projectColor])),
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
                  IconButton(
                    icon: Icon(Icons.alarm_rounded),
                    tooltip: 'Edit Due Date',
                    onPressed: () {},
                  ),
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
                                        type: 'tasks', itemID: task.id);
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
                leading: OutlinedButton.icon(
                  style: DynamicColorTheme.of(context)
                      .data
                      .outlinedButtonTheme
                      .style,
                  icon: Icon(Icons.topic_rounded,
                      color: colorList[task.project.projectColor]),
                  label: Text(task.project.projectName,
                      style: DynamicColorTheme.of(context)
                          .data
                          .textTheme
                          .subtitle2),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return ProjectPage(project: task.project);
                      }),
                    );
                  },
                ),
                trailing: RichText(
                    text: TextSpan(
                        text: 'Status: ',
                        style: DynamicColorTheme.of(context)
                            .data
                            .textTheme
                            .subtitle2,
                        children: <TextSpan>[
                      TextSpan(
                          text: task.status.statusName,
                          style: DynamicColorTheme.of(context)
                              .data
                              .textTheme
                              .subtitle1
                              .copyWith(color: colorList[task.status.statusColor]))
                    ])),
              ),
              ListTile(
                dense: true,
                // leading: Text('Subtasks: $subtaskCount',
                //     style: DynamicColorTheme.of(context).data.textTheme.subtitle1),
                title: Text(
                    'Recorded Time: ${DateTimeFunctions().timeToText(seconds: recordedTime)}',
                    style:
                        DynamicColorTheme.of(context).data.textTheme.subtitle2),
              ),
              ListTile(
                dense: true,
                title: Text(
                    task.dueDate.year == 0
                        ? 'Due: '
                        : 'Due: ${DateTimeFunctions().dateToText(date: task.dueDate)}',
                    style:
                        DynamicColorTheme.of(context).data.textTheme.subtitle2),
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
