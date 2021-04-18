import 'package:flutter/material.dart';
import 'package:productivity_app/Home_Dashboard/screens/components/pageview_row.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_expansion_tile.dart';
import 'package:productivity_app/Task_Feature/services/tasks_data.dart';
import 'package:provider/provider.dart';

class TaskDueRow extends StatelessWidget {
  TaskDueRow({Key key}) : super(key: key);

  List<Widget> pages = [TaskDueToday(), TaskDueThisWeek(), TaskPastDue()];

  @override
  Widget build(BuildContext context) {
    return PageViewRow(pages: pages);
  }
}

class TaskDueToday extends StatelessWidget {
  const TaskDueToday({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = Provider.of<TaskService>(context)
        .getTasksDueToday(Provider.of<List<Task>>(context));
    return Column(
      children: [
        ListTile(
          title: Text('Tasks Due Today'),
          trailing: Text(tasks.length.toString(), style: Theme.of(context).textTheme.subtitle1),
        ),
        Expanded(
          child: tasks == null
              ? Center(child: CircularProgressIndicator())
              : tasks.isEmpty
                  ? ListTile(
                      title: Text('No Tasks Due Today',
                          style: Theme.of(context).textTheme.subtitle1))
                  : ListView(
                      children: tasks
                          .map((task) => TaskExpansionTile(task: task))
                          .toList(),
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
    List<Task> tasks = Provider.of<TaskService>(context)
        .getTasksDueThisWeek(Provider.of<List<Task>>(context));
    return Column(
      children: [
        ListTile(
          title: Text('Tasks Due This Week'),
          trailing: Text(tasks.length.toString(), style: Theme.of(context).textTheme.subtitle1),
        ),
        Expanded(
          child: tasks == null
              ? Center(child: CircularProgressIndicator())
              : tasks.isEmpty
                  ? ListTile(
                      title: Text('No Tasks Due This Week',
                          style: Theme.of(context).textTheme.subtitle1))
                  : ListView(
                      children: tasks
                          .map((task) => TaskExpansionTile(task: task))
                          .toList(),
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
    List<Task> tasks = Provider.of<TaskService>(context)
        .getTasksPastDue(Provider.of<List<Task>>(context));
    return Column(
      children: [
        ListTile(
          title: Text('Late Tasks'),
          trailing: Text(tasks.length.toString(), style: Theme.of(context).textTheme.subtitle1),
        ),
        Expanded(
          child: tasks == null
              ? Center(child: CircularProgressIndicator())
              : tasks.isEmpty
                  ? ListTile(
                      title: Text('No Late Tasks',
                          style: Theme.of(context).textTheme.subtitle1))
                  : ListView(
                      children: tasks
                          .map((task) => TaskExpansionTile(task: task))
                          .toList(),
                    ),
        ),
      ],
    );
  }
}
