import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Services/database.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/providers/task_edit_state.dart';
import 'package:productivity_app/Task_Feature/services/tasks_data.dart';
import 'package:provider/provider.dart';

class StatusPicker extends StatelessWidget {
  final Function(Status) saveStatus;
  final Task task;
  const StatusPicker({Key key, this.saveStatus, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MaterialColor> colorList = AppColors().colorList;
    final List<Status> statuses = Provider.of<List<Status>>(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: statuses.map((status) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: OutlinedButton.icon(
              onPressed: () {
                saveStatus(status);
              },
              icon: task.status.id == status.id
                  ? Icon(Icons.check_circle_rounded,
                      color: colorList[status.statusColor])
                  : Icon(Icons.circle, color: colorList[status.statusColor]),
              label: Text(status.statusName),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class StatusPickerDropDown extends StatelessWidget {
  final Task task;
  final Icon icon;

  const StatusPickerDropDown({Key key, this.task, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MaterialColor> colorList = AppColors().colorList;
    final DatabaseService databaseService =
        Provider.of<DatabaseService>(context);
    final List<Status> statuses = Provider.of<List<Status>>(context);
    final TaskService taskService = Provider.of<TaskService>(context);
    return PopupMenuButton(
        icon: icon,
        tooltip: 'Change Status',
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        itemBuilder: (BuildContext context) {
          return statuses.map((status) {
            return PopupMenuItem(
              value: status,
              child: ListTile(
                title: Text(status.statusName,
                    style: DynamicColorTheme.of(context)
                        .data
                        .textTheme
                        .subtitle1
                        .copyWith(color: colorList[status.statusColor])),
                onTap: () {
                  databaseService.updateItem(
                      type: 'tasks',
                      itemID: task.id,
                      updateData: {'status': status.statusName});
                  Navigator.pop(context);
                },
              ),
            );
          }).toList();
        });
  }
}
