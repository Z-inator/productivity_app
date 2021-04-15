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
    final TaskService taskService = Provider.of<TaskService>(context);
    final List<Project> projects = Provider.of<List<Project>>(context);
    final List<Task> tasks = Provider.of<List<Task>>(context);
    return projects == null
        ? Center(child: CircularProgressIndicator())
        : projects.isEmpty
            ? Center(child: Text('Add Projects to group Tasks'))
            : ListView(
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
                          ),    
                          GroupedTasks(
                              associatedTasks: taskService.getTasksByProject(tasks, project))
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
  }
}
