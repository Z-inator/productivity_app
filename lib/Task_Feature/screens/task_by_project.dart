import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/providers/project_edit_state.dart';
import 'package:productivity_app/Task_Feature/screens/components/grouped_tasks.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_expansion_tile.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_edit_bottomsheet.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:productivity_app/Task_Feature/services/tasks_data.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:provider/provider.dart';

class TasksByProject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Project> projects = Provider.of<List<Project>>(context);
    final List<Task> tasks = Provider.of<List<Task>>(context);
    return projects == null || tasks == null
        ? Center(child: CircularProgressIndicator())
        : TaskByProjectBody(projects: projects, tasks: tasks);
  }
}

class TaskByProjectBody extends StatelessWidget {
  const TaskByProjectBody({
    Key key,
    @required this.projects,
    @required this.tasks,
  }) : super(key: key);

  final List<Project> projects;
  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    final TaskService state = Provider.of<TaskService>(context);
    final List<TimeEntry> timeEntries = Provider.of<List<TimeEntry>>(context);
    return ListView(
      padding: EdgeInsets.only(bottom: 100),
      children: projects.map((Project project) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProjectExpansionTile(
                    project: project,
                    tasks: state.getGroupedTasksByProject(context, project),
                    timeEntries: Provider.of<TimeService>(context)
                         .getGroupedTimeEntriesByProject(timeEntries, project),
                ),    
                GroupedTasks(
                    associatedTasks: state.getGroupedTasksByProject(context, project))
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
