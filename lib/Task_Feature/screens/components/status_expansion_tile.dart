import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/widgets/edit_bottom_sheets.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/status_edit_page.dart';

class StatusExpansionTile extends StatelessWidget {
  final Status status;
  final int numberOfTasks;
  const StatusExpansionTile({Key key, this.status, this.numberOfTasks})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: DynamicTheme.of(context)
            .theme
            .copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          key: key,
          leading: Icon(Icons.circle, color: Color(status.statusColor)),
          title: Text(status.statusName,
              style: DynamicTheme.of(context).theme.textTheme.subtitle1),
          children: [
            ListTile(
                title: Text('Tasks: $numberOfTasks',
                    style: DynamicTheme.of(context).theme.textTheme.subtitle2),
                trailing: IconButton(
                  icon: Icon(Icons.add_rounded),
                  tooltip: 'Add Task',
                  color: DynamicTheme.of(context).theme.iconTheme.color,
                  onPressed: () => EditBottomSheet().buildEditBottomSheet(
                      context: context,
                      bottomSheet: TaskEditBottomSheet(
                          isUpdate: false, task: Task(status: status))),
                )),
            ListTile(
              title: Text('Description:',
                  style: DynamicTheme.of(context).theme.textTheme.subtitle2),
              subtitle: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vel.',
                  style: DynamicTheme.of(context).theme.textTheme.subtitle2,
                  overflow: TextOverflow.fade,
                  maxLines: 3),
              trailing: IconButton(
                icon: Icon(Icons.edit_rounded),
                tooltip: 'Edit Statuses',
                color: DynamicTheme.of(context).theme.iconTheme.color,
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StatusEditPage())),
              ),
            )
          ],
        ));
  }
}
