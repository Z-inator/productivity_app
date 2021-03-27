import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productivity_app/models/projects.dart';
import 'package:productivity_app/models/tasks.dart';
import 'package:productivity_app/models/status.dart';
import 'package:productivity_app/services/Tasks_data.dart';
import 'package:productivity_app/shared_components/color_functions.dart';
import 'package:productivity_app/shared_components/datetime_functions.dart';
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
  Task newTask = Task();
  Project newProject;
  DateTime _dueDate;
  TimeOfDay _dueTime;
  Duration _addedTime;

  Future selectDate() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _dueDate ?? widget.task.dueDate ?? DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2100));
    if (picked != null) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  Future selectTime() async {
    final TimeOfDay pickedTime = await showTimePicker(
        context: context,
        initialTime: _dueTime ??
            (widget.task.dueDate.hour == 0
                ? TimeOfDay.now()
                : TimeOfDay.fromDateTime(widget.task.dueDate)));
    if (pickedTime != null) {
      setState(() {
        _dueTime = pickedTime;
      });
    }
  }

  Future addTime() async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Time Worked'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 50),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(5),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor)),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3)
                    ],
                    onChanged: (value) {
                      setState(() {
                        _addedTime =
                            _addedTime + Duration(hours: int.parse(value));
                      });
                    },
                  ),
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      ':',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 50),
                    )),
                Expanded(
                  child: TextField(               // TODO: add forced 0 to left if only 1 digit
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 50),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(5),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor)),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                      MinuteRangeTextInputFormatter()
                    ],
                    onChanged: (value) {
                      setState(() {
                        _addedTime =
                            _addedTime + Duration(minutes: int.parse(value));
                      });
                    },
                  ),
                ),
              ],
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Theme.of(context).unselectedWidgetColor,
                        )),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel')),
                        TextButton(
                            onPressed: () {
                              if (_addedTime.inSeconds != 0) {
                                setState(() {
                                  newTask.taskTime += _addedTime.inSeconds;
                                });
                              }
                              Navigator.pop(context);
                            },
                            child: Text('Ok')),
                      ],
                    ),
                  )
                ],
              ),
            ],
          );
        });
  }

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
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText:
                      newTask.taskName ?? widget.task.taskName ?? 'Task Name'),
              textAlign: TextAlign.center,
              onChanged: (newText) {
                newTask.taskName = newText;
              },
            ),
          ),
          PopupMenuButton(
            child: ListTile(
              leading: Icon(
                Icons.circle,
                color: Color((newProject == null)
                    ? (widget.associatedProject.projectColor ?? 4285887861)
                    : newProject.projectColor),
              ),
              title: Text(
                  (newProject == null)
                      ? (widget.associatedProject.projectName ??
                          'Select Project')
                      : newProject.projectName,
                  style: Theme.of(context).textTheme.subtitle1),
              trailing: Icon(Icons.arrow_drop_down_rounded,
                  color: Theme.of(context).unselectedWidgetColor),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))),
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
                          newTask.status = status.statusName;
                        });
                      },
                      icon: (newTask.status ?? widget.task.status) ==
                              status.statusName
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Due:',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              OutlinedButton.icon(
                onPressed: selectDate,
                icon: Icon(Icons.today_rounded),
                label: Text(_dueDate == null
                    ? DateTimeFunctions()
                        .dateTimeToTextDate(date: widget.task.dueDate)
                    : DateTimeFunctions().dateTimeToTextDate(date: _dueDate)),
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)))),
              ),
              OutlinedButton.icon(
                onPressed: selectTime,
                icon: Icon(
                    newTask.dueDate == null && widget.task.dueDate.hour == 0
                        ? Icons.more_time_rounded
                        : Icons.schedule_rounded),
                label: Text((_dueTime == null && widget.task.dueDate.hour == 0)
                    ? 'Add Due Time'
                    : (_dueTime == null
                        ? DateTimeFunctions()
                            .dateTimeToTextTime(date: widget.task.dueDate)
                        : _dueTime.format(context))),
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)))),
              ),
            ],
          ),
          // TODO: time input for taskTime
          OutlinedButton(
              onPressed: addTime,
              child: Text(newTask.taskTime == null
                  ? 'Total Tracked Time: ${TimeFunctions().timeToText(seconds: widget.task.taskTime)}'
                  : 'Total Tracked Time: ${TimeFunctions().timeToText(seconds: newTask.taskTime)}')),
          Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton.icon(
                icon: Icon(Icons.check_circle_outline_rounded),
                label: Text('Update'),
                onPressed: () {
                  // TaskService()
                  //     .updateTask(taskID: widget.task.taskID, updateData: {
                  //   'taskName': newTask.taskName ?? widget.task.taskName,
                  //   'projectName':
                  //       newTask.projectName ?? widget.task.projectName,
                  //   'status': newTask.status ?? widget.task.status,
                  //   'dueDate': newTask.dueDate ?? widget.task.dueDate,
                  //   'createDate': newTask.createDate ?? widget.task.createDate,
                  //   'taskTime': newTask.taskTime ?? widget.task.taskTime
                  // });
                  // Navigator.pop(context);
                  print(newTask.dueDate);
                },
              ))
        ],
      ),
    );
  }
}

class MinuteRangeTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue == '') {
      return TextEditingValue();
    } else if (int.parse(newValue.text) < 1) {
      return TextEditingValue().copyWith(text: '1');
    }
    return int.parse(newValue.text) > 59
        ? TextEditingValue().copyWith(text: '59')
        : newValue;
  }
}
