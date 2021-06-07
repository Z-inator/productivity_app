import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Shared/Shared.dart';
import '../../../Task_Feature/Task_Feature.dart';
import '../../../Time_Feature/Time_Feature.dart';

class TaskPicker extends StatelessWidget {
  final Function(Task?) saveTask;
  final Widget child;
  final List<Task> tasks;
  const TaskPicker(
      {Key? key,
      required this.saveTask,
      required this.child,
      required this.tasks})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MaterialColor> colorList = AppColorList;
    return PopupMenuButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry>[
            PopupMenuItem(
                child: ListTile(
              leading: Icon(
                Icons.circle,
                color: Colors.grey,
              ),
              title: Text('No Task'),
              onTap: () {
                saveTask(null);
                Navigator.pop(context);
              },
            )),
            PopupMenuDivider(),
            PopupMenuItem(
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: tasks
                        .map((task) => ListTile(
                              leading: Icon(
                                Icons.check_circle_rounded,
                                color: DynamicColorTheme.of(context).isDark
                                    ? colorList[task.status!.statusColor!]
                                        .shade200
                                    : colorList[task.status!.statusColor!],
                              ),
                              title: Text(task.taskName!),
                              onTap: () {
                                saveTask(task);
                                Navigator.pop(context);
                              },
                            ))
                        .toList(),
                  ),
                ),
              ),
            )
          ];
        },
        child: child);
  }
}
