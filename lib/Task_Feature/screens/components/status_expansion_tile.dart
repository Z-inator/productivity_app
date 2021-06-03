import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';

import '../../../Shared/Shared.dart';
import '../../../Task_Feature/Task_Feature.dart';

class StatusExpansionTile extends StatelessWidget {
  final Status status;
  final int numberOfTasks;
  const StatusExpansionTile({Key key, this.status, this.numberOfTasks})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MaterialColor> colorList = AppColorList;
    return Theme(
        data: DynamicColorTheme.of(context)
            .data
            .copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          key: key,
          leading: Icon(Icons.circle,
              color: DynamicColorTheme.of(context).isDark
                  ? colorList[status.statusColor].shade200
                  : colorList[status.statusColor]),
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
