import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/widgets/edit_bottom_sheets.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/providers/status_edit_state.dart';
import 'package:productivity_app/Task_Feature/providers/task_edit_state.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/status_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/status_edit_page.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Task_Feature/services/statuses_data.dart';
import 'package:productivity_app/Task_Feature/services/tasks_data.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:provider/provider.dart';

class StatusExpansionTile extends StatelessWidget {
  final Status status;
  const StatusExpansionTile({Key key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StatusService statusService = Provider.of<StatusService>(context);
    final TaskService taskService = Provider.of<TaskService>(context);
    List<Task> tasks =
        taskService.getTasksByStatus(Provider.of<List<Task>>(context), status);
    int taskCount = statusService.getTaskCount(tasks, status);
    return Theme(
        data: DynamicColorTheme.of(context)
            .data
            .copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          key: key,
          leading: Icon(Icons.circle, color: Color(status.statusColor)),
          title: Text(
            status.statusName,
            style: DynamicColorTheme.of(context)
                .data
                .textTheme
                .subtitle1
          ),
          children: [
            ListTile(
                title: Text('Tasks: $taskCount',
                    style:
                        DynamicColorTheme.of(context).data.textTheme.subtitle2),
                trailing: IconButton(
                  icon: Icon(Icons.add_rounded),
                  tooltip: 'Add Task',
                  color: DynamicColorTheme.of(context).data.iconTheme.color,
                  onPressed: () => EditBottomSheet().buildEditBottomSheet(
                      context: context,
                      bottomSheet: TaskEditBottomSheet(
                          isUpdate: false, task: Task(status: status))),
                )),
            ListTile(
              title: Text('Description:',
                  style:
                      DynamicColorTheme.of(context).data.textTheme.subtitle2),
              subtitle: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vel.',
                  style: DynamicColorTheme.of(context).data.textTheme.subtitle2,
                  overflow: TextOverflow.fade,
                  maxLines: 3),
              trailing: IconButton(
                icon: Icon(Icons.edit_rounded),
                tooltip: 'Edit Statuses',
                color: DynamicColorTheme.of(context).data.iconTheme.color,
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StatusEditPage())),
              ),
            )
          ],
        ));
  }
}
