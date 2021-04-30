import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/providers/page_state.dart';
import 'package:productivity_app/Shared/widgets/date_and_time_pickers.dart';
import 'package:productivity_app/Shared/widgets/edit_bottom_sheets.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/providers/task_edit_state.dart';
import 'package:productivity_app/Task_Feature/providers/task_page_state.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/status_picker.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/project_page.dart';
import 'package:productivity_app/Task_Feature/screens/task_by_status.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Task_Feature/services/tasks_data.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/screens/components/time_entry_edit_bottomsheet.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:provider/provider.dart';

class TaskExpansionTile extends StatelessWidget {
  final Task task;
  const TaskExpansionTile({Key key, this.task});

  @override
  Widget build(BuildContext context) {
    final TaskService taskService = Provider.of<TaskService>(context);
    final TimeService timeService = Provider.of<TimeService>(context);
    List<TimeEntry> timeEntries = timeService.getTimeEntriesByTask(
        Provider.of<List<TimeEntry>>(context), task);
    int recordedTime = taskService.getRecordedTime(timeEntries, task);
    int subtaskCount = 0;   // TODO: implement Subtasks
    return ExpansionTile(
      leading: Icon(Icons.check_circle_rounded, color: Color(task.status.statusColor)),
      title: Text(task.taskName),
      subtitle: Text(task.project.projectName,
          style: TextStyle(color: Color(task.project.projectColor))),
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
                      icon: Icon(Icons.timelapse_rounded),
                      tooltip: 'Add Time Entry',
                      onPressed: () => EditBottomSheet().buildEditBottomSheet(
                          context: context,
                          bottomSheet: TimeEntryEditBottomSheet(
                              isUpdate: false, entry: TimeEntry(task: task)))),
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
                                    taskService.deleteTask(taskID: task.taskID);
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
                leading: OutlinedButton.icon(
                  style: Theme.of(context).outlinedButtonTheme.style,
                  icon: Icon(Icons.topic_rounded,
                      color: Color(task.project.projectColor)),
                  label: Text(task.project.projectName,
                      style: Theme.of(context).textTheme.subtitle1),
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
                        style: Theme.of(context).textTheme.subtitle1,
                        children: <TextSpan>[
                      TextSpan(
                          text: task.status.statusName,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(color: Color(task.status.statusColor)))
                    ])),
              ),
              ListTile(
                leading: Text('Subtasks: $subtaskCount',
                    style: Theme.of(context).textTheme.subtitle1),
                trailing: Text(
                    'Recorded Time: ${TimeFunctions().timeToText(seconds: recordedTime)}',
                    style: Theme.of(context).textTheme.subtitle1),
              ),
              ListTile(
                title: Text(
                    task.dueDate.year == 0
                        ? 'Due: '
                        : 'Due: ${DateTimeFunctions().dateToText(date: task.dueDate)}',
                    style: Theme.of(context).textTheme.subtitle1),
              ),
              Text(
                  'Created: ${DateTimeFunctions().dateTimeToTextDate(date: task.createDate)}',
                  style: Theme.of(context).textTheme.caption),
            ],
          ),
        )
      ],
    );
  }
}
