import 'package:flutter/material.dart';
import 'package:productivity_app/models/projects.dart';
import 'package:productivity_app/models/tasks.dart';
import 'package:productivity_app/screens/tasks/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/screens/tasks/components/task_edit_bottomsheet.dart';
import 'package:productivity_app/shared_components/datetime_functions.dart';
import 'package:productivity_app/shared_components/time_functions.dart';
import 'package:provider/provider.dart';

class TasksByProject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Project> projects = Provider.of<List<Project>>(context);
    return ListView(
      padding: EdgeInsets.only(bottom: 100),
      children: projects.map((Project project) {
        String projectID = project.projectID;
        String projectName = project.projectName;
        Color projectColor = Color(project.projectColor);
        String projectClient = project.projectClient;
        final String projectTime =
            TimeFunctions().timeToText(seconds: project.projectTime);
        return Container(
          padding: EdgeInsets.all(10),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
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
                        color: projectColor,
                      ),
                      title: Text(
                        projectName,
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
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                builder: (BuildContext context) {
                                  return ProjectEditBottomSheet(project: project);
                                });
                          }),
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Client: $projectClient',
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
                              Text('Time: $projectTime',
                                  style: Theme.of(context).textTheme.subtitle1),
                              OutlinedButton.icon(
                                icon: Icon(Icons.playlist_add_check_rounded),
                                label: Text(
                                    'Tasks\n10'), // TODO: make this a live number
                                onPressed: () {
                                  Navigator.pushNamed(context, '/taskscreen',
                                      arguments: projectName);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                Divider(),
                GroupByProject(
                  associatedProjectName: projectName,
                  associatedProjectID: projectID,
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class GroupByProject extends StatelessWidget {
  final String associatedProjectName;
  final String associatedProjectID;
  GroupByProject({this.associatedProjectName, this.associatedProjectID});

  List<Task> filterByProject(List<Task> tasks, String associatedProjectName) {
    return tasks
        .where((task) => task.projectName == associatedProjectName)
        .toList();
  }

  // TODO: look at adding an init method to run the .where when the widget is created

  @override
  Widget build(BuildContext context) {
    final List<Task> tasks = Provider.of<List<Task>>(context);
    return ListBody(
      children: filterByProject(tasks, associatedProjectName).map((Task task) {
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
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      builder: (BuildContext context) {
                        return TaskEditBottomSheet(task: task);
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
                    Text('Status: ${task.status}',
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
