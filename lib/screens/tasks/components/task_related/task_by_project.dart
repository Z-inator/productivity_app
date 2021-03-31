import 'package:flutter/material.dart';
import 'package:productivity_app/models/projects.dart';
import 'package:productivity_app/models/tasks.dart';
import 'package:productivity_app/shared_components/project_related/project_edit_bottomsheet.dart';
import 'package:productivity_app/shared_components/task_related/task_edit_bottomsheet.dart';
import 'package:productivity_app/shared_components/datetime_functions.dart';
import 'package:productivity_app/shared_components/time_functions.dart';
import 'package:provider/provider.dart';

class TasksByProject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Project> projects = Provider.of<List<Project>>(context);
    List<Task> tasks = Provider.of<List<Task>>(context);
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
    return ListView(
      padding: EdgeInsets.only(bottom: 100),
      children: projects.map((Project project) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))),
            elevation: 5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                      accentColor: Theme.of(context).unselectedWidgetColor,
                    ),
                    child: ExpansionTile(
                      initiallyExpanded: false,
                      leading: Icon(
                        Icons.circle,
                        color: Color(project.projectColor),
                      ),
                      title: Text(
                        project.projectName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: IconButton(
                          icon: Icon(Icons.edit_rounded),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled:
                                    true, // Allows the modal to me dynamic and keeps the menu above the keyboard
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25))),
                                builder: (BuildContext context) {
                                  return ProjectEditBottomSheet(
                                      project: project);
                                });
                          }),
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Client: ${project.projectClient}',
                                  style: Theme.of(context).textTheme.subtitle1),
                              Text('Tasks: 10',
                                  style: Theme.of(context).textTheme.subtitle1),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Time: ${project.projectTime}',
                                  style: Theme.of(context).textTheme.subtitle1),
                              OutlinedButton.icon(
                                icon: Icon(Icons.playlist_add_check_rounded),
                                label: Text(
                                    'Tasks\n10'), // TODO: make this a live number
                                onPressed: () {
                                  Navigator.pushNamed(context, '/taskscreen',
                                      arguments: project.projectName);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                Divider(),
                GroupByProject(
                    associatedProjectTasks:
                        tasks.where((task) => task.project == project).toList())
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class GroupByProject extends StatelessWidget {
  final List<Task> associatedProjectTasks;
  GroupByProject({this.associatedProjectTasks});

  List<Task> filterByProject(List<Task> tasks, String associatedProjectName) {
    return tasks
        .where((task) => task.project.projectName == associatedProjectName)
        .toList();
  }

  // TODO: look at adding an init method to run the .where when the widget is created

  @override
  Widget build(BuildContext context) {
    return ListBody(
      children: associatedProjectTasks.map((Task task) {
        return Theme(
          data: Theme.of(context)
              .copyWith(accentColor: Theme.of(context).unselectedWidgetColor),
          child: ExpansionTile(
            initiallyExpanded: false,
            leading: Icon(
              Icons.play_arrow_rounded,
              color: Colors.green,
            ),
            title: Text(
              task.taskName,
            ),
            trailing: IconButton(
                icon: Icon(Icons.edit_rounded),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled:
                          true, // Allows the modal to me dynamic and keeps the menu above the keyboard
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      builder: (BuildContext context) {
                        return TaskEditBottomSheet(
                          task: task,
                          isUpdate: true,
                        );
                      });
                }),
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Due Date: ${DateTimeFunctions().dateToText(date: task.dueDate)}',
                        style: Theme.of(context).textTheme.subtitle1),
                    Text('Status: ${task.status.statusName}',
                        style: Theme.of(context).textTheme.subtitle1),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Time: ${TimeFunctions().timeToText(seconds: task.taskTime)}',
                        style: Theme.of(context).textTheme.subtitle1),
                    OutlinedButton.icon(
                      icon: Icon(Icons.playlist_add_check_rounded),
                      label: Text('Subtasks:\n10'),
                      onPressed: () {
                        // Navigator.pushNamed(context, '/taskscreen',
                        //     arguments: projectName);
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(
                    'Create Date: ${DateTimeFunctions().dateToText(date: task.createDate)}',
                    style: Theme.of(context).textTheme.subtitle1),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
