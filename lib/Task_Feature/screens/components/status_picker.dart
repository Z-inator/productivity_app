import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Shared/Shared.dart';
import '../../../Task_Feature/Task_Feature.dart';
import '../../../Services/database.dart';

class StatusPicker extends StatelessWidget {
  final Function(Status) saveStatus;
  final Task task;
  const StatusPicker({Key? key, required this.saveStatus, required this.task})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MaterialColor> colorList = AppColorList;
    final List<Status> statuses = Provider.of<List<Status>>(context);
    statuses.sort((a, b) => a.statusOrder!.compareTo(b.statusOrder!));
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
              icon: Icon(
                  task.status != null
                      ? task.status?.id == status.id
                          ? Icons.check_circle_rounded
                          : Icons.circle
                      : Icons.circle,
                  color: DynamicColorTheme.of(context).isDark
                      ? colorList[status.statusColor!].shade200
                      : colorList[status.statusColor!]),
              label: Text(status.statusName!),
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

  const StatusPickerDropDown({Key? key, required this.task, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MaterialColor> colorList = AppColorList;
    ThemeData themeData = DynamicColorTheme.of(context).data;
    final DatabaseService databaseService =
        Provider.of<DatabaseService>(context);
    final List<Status> statuses = Provider.of<List<Status>>(context);
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
                title: Text(status.statusName!,
                    style: themeData
                        .textTheme
                        .subtitle1!
                        .copyWith(
                            color: DynamicColorTheme.of(context).isDark
                                ? colorList[status.statusColor!].shade200
                                : colorList[status.statusColor!])),
                onTap: () {
                  databaseService.updateItem(
                      collectionReference: databaseService.taskReference,
                      objectID: task.id,
                      updateData: {'status': status.statusName});
                  Navigator.pop(context);
                },
              ),
            );
          }).toList();
        });
  }
}
