import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Time_Feature/providers/time_entry_edit_state.dart';
import 'package:provider/provider.dart';

class TaskPicker extends StatelessWidget {
  final Function(Task) saveTask;
  final Widget child;
  const TaskPicker({Key key, this.saveTask, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TimeEntryEditState timeEntryEditState =
        Provider.of<TimeEntryEditState>(context);
    List<Task> tasks = Provider.of<List<Task>>(context);
    if (timeEntryEditState.newEntry.project.id.isNotEmpty) {
      tasks = tasks
          .where((task) =>
              task.project.id == timeEntryEditState.newEntry.project.id)
          .toList();
    }
    return PopupMenuButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry>[
            PopupMenuItem(
                child: ListTile(
              leading: Icon(
                Icons.circle,
                color: Color(4285887861),
              ),
              title: Text('No Task',
                  style: DynamicTheme.of(context).theme.textTheme.subtitle1),
              onTap: () {
                saveTask(Task());
                Navigator.pop(context);
              },
            )),
            PopupMenuDivider(),
            PopupMenuItem(
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  children: tasks.map((task) {
                    return ListTile(
                      leading: Icon(
                        Icons.check_circle_rounded,
                        color: Color(task.status.statusColor),
                      ),
                      title: Text(task.taskName,
                          style: DynamicTheme.of(context)
                              .theme
                              .textTheme
                              .subtitle1),
                      onTap: () {
                        saveTask(task);
                        Navigator.pop(context);
                      },
                    );
                  }).toList(),
                ),
              ),
            )
          ];
        },
        child: child);
  }
}
