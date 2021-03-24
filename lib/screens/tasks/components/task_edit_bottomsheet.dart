import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/models/projects.dart';
import 'package:productivity_app/models/tasks.dart';
import 'package:productivity_app/models/status.dart';
import 'package:productivity_app/services/Tasks_data.dart';
import 'package:productivity_app/shared_components/color_functions.dart';
import 'package:productivity_app/shared_components/time_functions.dart';
import 'package:provider/provider.dart';

class TaskEditBottomSheet extends StatefulWidget {
  final Task task;
  final Project associatedProject;
  TaskEditBottomSheet({this.task, this.associatedProject});

  @override
  _TaskEditBottomSheetState createState() => _TaskEditBottomSheetState();
}

class _TaskEditBottomSheetState extends State<TaskEditBottomSheet> {
  String newTaskName;
  String newProjectName;
  String newStatus;
  DateTime newDueDate;
  int newTaskTime;
  Project newProject;

  @override
  Widget build(BuildContext context) {
    List<Status> statuses = Provider.of<List<Status>>(context);
    statuses.sort((a, b) => a.statusOrder.compareTo(b.statusOrder));
    List<Project> projects = Provider.of<List<Project>>(context);
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
                hintText: newTaskName ?? widget.task.taskName ?? 'Task Name'),
            textAlign: TextAlign.center,
            onChanged: (newText) {
              newTaskName = newText;
            },
          ),
          // TODO: project selector for projectName
          // TODO: this widget is causing errors due to newProject returning null
          PopupMenuButton(
            child: ListTile(
              leading: Icon(
                Icons.circle,
                color:
                    Color(newProject.projectColor ?? widget.associatedProject.projectColor ?? 4285887861),
              ),
              title: Text(
                  newProject.projectName ?? widget.associatedProject.projectName ?? 'Select Project',
                  style: Theme.of(context).textTheme.subtitle1),
              trailing: Icon(Icons.arrow_drop_down_rounded,
                  color: Theme.of(context).unselectedWidgetColor),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry>[
                PopupMenuItem(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width / 2,
                    child: ListView(
                      children: projects.map((project) {
                        return ListTile(
                          leading: Icon(
                            Icons.circle,
                            color: Color(project.projectColor ?? 4285887861),
                          ),
                          title: Text(project.projectName,
                              style: Theme.of(context).textTheme.subtitle1),
                          onTap: () {
                            setState(() {
                              newProject = project;
                            });
                            Navigator.pop(context);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                )
              ];
            },
          ),
          StatefulBuilder(
              builder: (BuildContext context, StateSetter statusSetState) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: statuses.map((status) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: OutlinedButton.icon(
                      onPressed: () {
                        statusSetState(() {
                          newStatus = status.statusName;
                        });
                      },
                      icon:
                          (newStatus ?? widget.task.status) == status.statusName
                              ? Icon(Icons.check_circle_rounded,
                                  color: Color(status.statusColor))
                              : Icon(Icons.circle,
                                  color: Color(status.statusColor)),
                      label: Text(status.statusName),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }),
          // TODO: date selector for dueDate
          // TODO: time input for taskTime
          Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton.icon(
                icon: Icon(Icons.check_circle_outline_rounded),
                label: Text('Submit'),
                onPressed: () {
                  TaskService()
                      .updateTask(taskID: widget.task.taskID, updateData: {
                    'taskName': newTaskName ?? widget.task.taskName,
                    'projectName': newProjectName ?? widget.task.projectName,
                    'status': newStatus ?? widget.task.status,
                    'dueDate': newDueDate ?? widget.task.dueDate,
                    'taskTime': newTaskTime ?? widget.task.taskTime
                  });
                  Navigator.pop(context);
                },
              ))
        ],
      ),
    );
  }
}
