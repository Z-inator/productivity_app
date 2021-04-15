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
    final TaskService state = Provider.of<TaskService>(context);
    
    return ExpansionTile(
      leading: Icon(Icons.circle, color: Color(task.status.statusColor)),
      title: Text(task.taskName),
      subtitle: Text(task.project.projectName, style: TextStyle(color: Color(task.project.projectColor))),
      children: [
        ExpansionTile(
          childrenPadding: EdgeInsets.symmetric(horizontal: 20),
          title: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.play_arrow_rounded),
                  tooltip: 'Start Timer',
                  color: Colors.green,
                  onPressed: () {},
                ),
                IconButton(
                    icon: Icon(Icons.timelapse_rounded),
                    tooltip: 'Add Time Entry',
                    onPressed: () =>
                        DateAndTimePickers().buildTimeRangePicker()),
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
                  icon: Icon(Icons.edit_rounded),
                  tooltip: 'Edit Task',
                  onPressed: () => EditBottomSheet().buildEditBottomSheet(
                      context: context,
                      bottomSheet: TaskEditBottomSheet(isUpdate: true, task: task)),
                ),
                StatusPickerDropDown()
              ]),
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    text: TextSpan(
                        text: 'Project: ',
                        style: Theme.of(context).textTheme.subtitle1,
                        children: <TextSpan>[
                      TextSpan(
                          text: task.project.projectName,
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              color: Color(task.project.projectColor)))
                    ])),
                RichText(
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
              ],
            ),
            Text('Subtasks: ', style: Theme.of(context).textTheme.subtitle1),
            Text(
                'Recorded Time: ${TimeFunctions().timeToText(seconds: state.getRecordedTime(context, task))}',
                style: Theme.of(context).textTheme.subtitle1),
            Text(
                task.dueDate.year == 0
                    ? 'Due: '
                    : 'Due: ${DateTimeFunctions().dateToText(date: task.dueDate)}',
                style: Theme.of(context).textTheme.subtitle1),
            Text(
                'Create Date: ${DateTimeFunctions().dateTimeToTextDate(date: task.createDate)}',
                style: Theme.of(context).textTheme.caption),
          ],
        )
      ],
    );
  }
}
