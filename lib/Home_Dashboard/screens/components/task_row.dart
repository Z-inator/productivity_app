import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Task_Feature/Task_Feature.dart';
import '../../../Home_Dashboard/Home_Dashboard.dart';
import '../../../Shared/Shared.dart';

class ImportantTaskListTile extends StatelessWidget {
  final Task task;
  const ImportantTaskListTile({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MaterialColor> colorList = AppColorList;
    return ListTile(
      leading: StatusPickerDropDown(
          task: task,
          icon: Icon(
            Icons.check_circle_rounded,
            color: DynamicColorTheme.of(context).isDark
                ? colorList[task.status!.statusColor!].shade200
                : colorList[task.status!.statusColor!],
          )),
      title: Text(
        task.taskName ?? 'NO TASK TITLE',
        style: DynamicColorTheme.of(context).data.textTheme.subtitle2,
      ),
      subtitle: Text(
          task.project?.projectName ?? 'NO PROJECT',
          style: DynamicColorTheme.of(context)
              .data
              .textTheme
              .subtitle1!
              .copyWith(
                  color: DynamicColorTheme.of(context).isDark
                      ? colorList[task.project!.projectColor!].shade200
                      : colorList[task.project!.projectColor!])),
      trailing: IconButton(
          icon: Icon(Icons.edit_rounded),
          onPressed: () => EditBottomSheet().buildEditBottomSheet(
              context: context,
              bottomSheet: TaskEditBottomSheet(isUpdate: true, task: task))),
    );
  }
}

class TaskDueRow extends StatelessWidget {
  List<Widget> pages = [TaskDueToday(), TaskDueThisWeek(), TaskPastDue()];

  TaskDueRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('Important Tasks',
              style: DynamicColorTheme.of(context).data.textTheme.headline4),
          // trailing: IconButton(
          //   icon: Icon(Icons.insights_rounded),
          //   tooltip: 'Reports',
          //   onPressed: () {},
          // ),
        ),
        Expanded(child: PageViewRow(pages: pages))
      ],
    );
  }
}

class TaskDueThisWeek extends StatelessWidget {
  const TaskDueThisWeek({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = Provider.of<TaskCharts>(context)
        .getTasksDueThisWeek(Provider.of<List<Task>>(context));
    return Column(
      children: [
        ListTile(
          title: Text('Tasks Due This Week'),
          trailing: Text(tasks.length.toString(),
              style: DynamicColorTheme.of(context).data.textTheme.subtitle1),
        ),
        Expanded(
          child: tasks == null
              ? Center(child: CircularProgressIndicator())
              : tasks.isEmpty
                  ? Center(
                      child: Text('No Tasks Due This Week',
                          style: DynamicColorTheme.of(context)
                              .data
                              .textTheme
                              .subtitle2))
                  : Card(
                      child: ListView(
                        children: tasks
                            .map((task) => ImportantTaskListTile(task: task))
                            .toList(),
                      ),
                    ),
        ),
      ],
    );
  }
}

class TaskDueToday extends StatelessWidget {
  const TaskDueToday({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = Provider.of<TaskCharts>(context)
        .getTasksDueToday(Provider.of<List<Task>>(context));
    return Column(
      children: [
        ListTile(
          title: Text('Tasks Due Today'),
          trailing: Text(tasks.length.toString(),
              style: DynamicColorTheme.of(context).data.textTheme.subtitle1),
        ),
        Expanded(
          child: tasks == null
              ? Center(child: CircularProgressIndicator())
              : tasks.isEmpty
                  ? Center(
                      child: Text('No Tasks Due Today',
                          style: DynamicColorTheme.of(context)
                              .data
                              .textTheme
                              .subtitle2))
                  : Card(
                      child: ListView(
                        children: tasks
                            .map((task) => ImportantTaskListTile(task: task))
                            .toList(),
                      ),
                    ),
        ),
      ],
    );
  }
}

class TaskPastDue extends StatelessWidget {
  const TaskPastDue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = Provider.of<TaskCharts>(context)
        .getTasksPastDue(Provider.of<List<Task>>(context));
    return Column(
      children: [
        ListTile(
          title: Text('Late Tasks'),
          trailing: Text(tasks.length.toString(),
              style: DynamicColorTheme.of(context).data.textTheme.subtitle1),
        ),
        Expanded(
          child: tasks == null
              ? Center(child: CircularProgressIndicator())
              : tasks.isEmpty
                  ? Center(
                      child: Text('No Late Tasks',
                          style: DynamicColorTheme.of(context)
                              .data
                              .textTheme
                              .subtitle2))
                  : Card(
                      child: ListView(
                        children: tasks
                            .map((task) => ImportantTaskListTile(task: task))
                            .toList(),
                      ),
                    ),
        ),
      ],
    );
  }
}
