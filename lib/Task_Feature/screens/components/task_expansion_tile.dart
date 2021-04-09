import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/widgets/time_range_picker.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/providers/task_edit_state.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/status_picker.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/project_page.dart';
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
  final List<TimeEntry> timeEntries;
  const TaskExpansionTile({Key key, this.task, this.timeEntries})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TaskService state = Provider.of<TaskService>(context);
    return ExpansionTile(
      leading: IconButton(
        icon: Icon(Icons.play_arrow_rounded),
        color: Colors.green,
        onPressed: () {},
      ),
      title: Text(
        task.taskName,
      ),
      children: [
        ListTile(
          title: RichText(
              text: TextSpan(
                  text: 'Project: ',
                  style: Theme.of(context).textTheme.subtitle1,
                  children: <TextSpan>[
                TextSpan(
                    text: task.project.projectName,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(color: Color(task.project.projectColor)))
              ])),
        ),
        ListTile(
            title: RichText(
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
            trailing: StatusPickerDropDown(task: task)),
        ListTile(
          title:
              Text('Subtasks: ', style: Theme.of(context).textTheme.subtitle1),
          trailing: IconButton(
            icon: Icon(Icons.add_rounded),
            tooltip: 'Add Subtask',
            onPressed: () {},
          ),
        ),
        ListTile(
          title: Text(
              'Recorded Time: ${TimeFunctions().timeToText(seconds: state.getRecordedTime(timeEntries, task))}',
              style: Theme.of(context).textTheme.subtitle1),
          trailing: RangeTimePicker(),
        ),
        ListTile(
          title: Text(
              'Due: ${DateTimeFunctions().dateToText(date: task.dueDate)}',
              style: Theme.of(context).textTheme.subtitle1),
          trailing: task.dueDate.isBefore(DateTime.now())
              ? IconButton(
                  icon: Icon(Icons.notifications_active_rounded,
                      color: Colors.red),
                  onPressed: () {},
                )
              : null,
        ),
        Container(
          margin: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton.icon(
                  icon: Icon(Icons.edit_rounded),
                  label: Text('Edit Task'),
                  onPressed: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled:
                          true, // Allows the modal to me dynamic and keeps the menu above the keyboard
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      builder: (BuildContext context) {
                        return ChangeNotifierProvider(
                            create: (context) => TaskEditState(isUpdate: true),
                            child: TaskEditBottomSheet(
                              task: task,
                              // isUpdate: true,
                            ));
                      })),
              ElevatedButton.icon(
                icon: Icon(Icons.open_with_rounded),
                label: Text('Project Page'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return ProjectPage(project: task.project);
                    }),
                  );
                },
              ),
            ],
          ),
        ),
        Text(
            'Create Date: ${DateTimeFunctions().dateTimeToTextDate(date: task.createDate)}',
            style: Theme.of(context).textTheme.caption),
      ],
    );
  }
}
