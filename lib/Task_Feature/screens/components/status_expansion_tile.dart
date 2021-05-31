import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
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
    List<MaterialColor> colorList = AppColors.colorList;
    return Theme(
        data: DynamicColorTheme.of(context)
            .data
            .copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          key: key,
          leading: Icon(Icons.circle, color: DynamicColorTheme.of(context).isDark ? colorList[status.statusColor].shade200 : colorList[status.statusColor]),
          title: Text(status.statusName,
              style: DynamicColorTheme.of(context).data.textTheme.subtitle1),
          children: [
            ListTile(
                title: Text('Tasks: $numberOfTasks',
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
