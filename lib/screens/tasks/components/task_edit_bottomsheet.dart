import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/models/tasks.dart';
import 'package:productivity_app/models/status.dart';
import 'package:productivity_app/services/Tasks_data.dart';
import 'package:productivity_app/shared_components/color_functions.dart';
import 'package:productivity_app/shared_components/time_functions.dart';
import 'package:provider/provider.dart';

class TaskEditBottomSheet extends StatefulWidget {
  final Task task;
  TaskEditBottomSheet({this.task});

  @override
  _TaskEditBottomSheetState createState() => _TaskEditBottomSheetState();
}

class _TaskEditBottomSheetState extends State<TaskEditBottomSheet> {
  String newTaskName;
  String newProjectName;
  String newStatus;
  DateTime newDueDate;
  int newTaskTime;

  @override
  Widget build(BuildContext context) {
    List<Status> statuses = Provider.of<List<Status>>(context);
    statuses.sort((a,b) => a.statusOrder.compareTo(b.statusOrder));
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration:
                InputDecoration(hintText: widget.task.taskName ?? 'Task Name'),
            textAlign: TextAlign.center,
            onChanged: (newText) {
              newTaskName = newText;
            },
          ),
          TextField(
            decoration: InputDecoration(
                hintText: widget.task.projectName ?? 'Project Name'),
            textAlign: TextAlign.center,
            onChanged: (newText) {
              newProjectName = newText;
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
          // TODO: implement date selector and time input for task creation
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
