import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Home_Dashboard/screens/components/pageview_row.dart';
import 'package:productivity_app/Home_Dashboard/services/charts_and_graphs.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Shared/widgets/edit_bottom_sheets.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/screens/components/status_picker.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_expansion_tile.dart';
import 'package:productivity_app/Task_Feature/services/tasks_data.dart';
import 'package:provider/provider.dart';

class TaskDueRow extends StatelessWidget {
  TaskDueRow({Key key}) : super(key: key);

  List<Widget> pages = [TaskDueToday(), TaskDueThisWeek(), TaskPastDue()];

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

class ImportantTaskListTile extends StatelessWidget {
  final Task task;
  const ImportantTaskListTile({Key key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MaterialColor> colorList = AppColors().colorList;
    return ListTile(
      leading: StatusPickerDropDown(
          task: task,
          icon: Icon(
            Icons.check_circle_rounded,
            color: colorList[task.status.statusColor],
          )),
      title: Text(
        task.taskName.isEmpty ? 'NO TASK TITLE' : task.taskName,
        style: DynamicColorTheme.of(context).data.textTheme.subtitle2,
      ),
      subtitle: Text(
          task.project.id.isEmpty ? 'NO PROJECT' : task.project.projectName,
          style: DynamicColorTheme.of(context)
              .data
              .textTheme
              .subtitle1
              .copyWith(color: colorList[task.project.projectColor])),
      trailing: IconButton(
          icon: Icon(Icons.edit_rounded),
          onPressed: () => EditBottomSheet().buildEditBottomSheet(
              context: context,
              bottomSheet: TaskEditBottomSheet(isUpdate: true, task: task))),
    );
  }
}

class TaskDueToday extends StatelessWidget {
  const TaskDueToday({Key key}) : super(key: key);

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
                          style: DynamicColorTheme.of(context).data.textTheme.subtitle2))
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

class TaskDueThisWeek extends StatelessWidget {
  const TaskDueThisWeek({Key key}) : super(key: key);

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
                          style: DynamicColorTheme.of(context).data.textTheme.subtitle2))
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
  const TaskPastDue({Key key}) : super(key: key);

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
                          style: DynamicColorTheme.of(context).data.textTheme.subtitle2))
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
