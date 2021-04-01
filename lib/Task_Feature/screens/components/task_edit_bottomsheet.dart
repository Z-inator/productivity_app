import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:productivity_app/Shared/widgets/hour_minute_picker.dart';
import 'package:productivity_app/Task_Feature/providers/task_edit_state.dart';
import 'package:provider/provider.dart';
import 'package:simple_time_range_picker/simple_time_range_picker.dart';

class TaskEditBottomSheet extends StatelessWidget {
  final Task task;
  final bool isUpdate;

  TaskEditBottomSheet({Key key, this.task, this.isUpdate}) : super(key: key);

  Project newProject = Project();

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<TaskEditState>(context);
    isUpdate ? state.updateTask(task) : state.addTask();
    return Container(
        margin: EdgeInsets.all(20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(
            decoration: InputDecoration(
                hintText: state.newTask.taskName ?? 'Enter Task Name'),
            textAlign: TextAlign.center,
            onChanged: (newText) {
              state.updateTaskName(newText);
            },
          ),
          ProjectPicker(
            saveProject: state.updateTaskProject,
          ),
          StatusPicker(
            saveStatus: state.updateTaskStatus,
          ),
          DueDatePicker(
            saveDueDate: state.updateTaskDueDate,
            saveDueTime: state.updateTaskDueTime,
            initialdate: state.newTask.dueDate,
          ),
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 10),
            child: Text(
              'Total Tracked Time: ${TimeFunctions().timeToText(seconds: state.newTask.taskTime)}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                ManualTimePicker(saveManualTime: state.updateTaskTime),
                RangeTimePicker(saveRangeTime: state.updateTaskTime),
              ]),
          Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton.icon(
                icon: Icon(Icons.check_circle_outline_rounded),
                label: Text(isUpdate ? 'Update' : 'Add'),
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
                  Navigator.pop(context);
                },
              ))
        ]));
  }
}

class ProjectPicker extends StatelessWidget {
  const ProjectPicker({Key key, this.associatedProject, this.saveProject})
      : super(key: key);
  final Project associatedProject;
  final Function(Project) saveProject;

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<TaskEditState>(context);
    List<Project> projects = Provider.of<List<Project>>(context);
    return PopupMenuButton(
      child: ListTile(
        leading: Icon(
          Icons.circle,
          color: Color(state.newTask.project.projectColor),
        ),
        title: Text(state.newTask.project.projectName ?? 'Add Project',
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
                      color: Color(project.projectColor),
                    ),
                    title: Text(project.projectName,
                        style: Theme.of(context).textTheme.subtitle1),
                    onTap: () {
                      saveProject(project);
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
              ),
            ),
          )
        ];
      },
    );
  }
}

class StatusPicker extends StatelessWidget {
  const StatusPicker({Key key, this.saveStatus}) : super(key: key);

  final Function(Status) saveStatus;

  @override
  Widget build(BuildContext context) {
    List<Status> statuses = Provider.of<List<Status>>(context);
    var state = Provider.of<TaskEditState>(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: statuses.map((status) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: OutlinedButton.icon(
              onPressed: () {
                saveStatus(status);
              },
              icon: state.newTask.status == null
                  ? Icon(Icons.circle, color: Color(status.statusColor))
                  : (state.newTask.status == status
                      ? Icon(Icons.check_circle_rounded,
                          color: Color(status.statusColor))
                      : Icon(Icons.circle, color: Color(status.statusColor))),
              label: Text(status.statusName),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class DueDatePicker extends StatelessWidget {
  final Function(DateTime) saveDueDate;
  final Function(TimeOfDay) saveDueTime;
  final DateTime initialdate;
  const DueDatePicker({Key key, this.saveDueDate, this.saveDueTime, this.initialdate})
      : super(key: key);

  Future selectDate(BuildContext context, DateTime initialDate) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: initialDate ?? DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2100));
    if (picked != null) {
      saveDueDate(picked);
    }
  }

  Future selectTime(BuildContext context, TimeOfDay initialTime) async {
    final TimeOfDay pickedTime = await showTimePicker(
        context: context, initialTime: initialTime ?? TimeOfDay.now());
    if (pickedTime != null) {
      saveDueTime(pickedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Due:',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        OutlinedButton.icon(
          onPressed: () => selectDate(context, initialdate),
          icon: Icon(Icons.today_rounded),
          label: Text(DateTimeFunctions()
                  .dateTimeToTextDate(date: initialdate) ??
              'Add Due Date'),
        ),
        OutlinedButton.icon(
          onPressed: () => selectTime(
              context, TimeOfDay.fromDateTime(initialdate)),
          icon: Icon(initialdate.hour == 0
              ? Icons.alarm_add_rounded
              : Icons.alarm_rounded),
          label: Text(initialdate.hour == 0
              ? 'Add Due Time'
              : DateTimeFunctions()
                  .dateTimeToTextTime(date: initialdate, context: context)),
        ),
      ],
    );
  }
}

class RangeTimePicker extends StatelessWidget {
  final Function(int) saveRangeTime;
  const RangeTimePicker({Key key, this.saveRangeTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: Icon(Icons.timelapse_rounded),
      onPressed: () => TimeRangePicker.show(
          context: context,
          onSubmitted: (TimeRangeValue value) {
            int startTimeNumber =
                value.startTime.hour * 60 + value.startTime.minute;
            int endTimeNumber = value.endTime.hour * 60 + value.endTime.minute;
            int differenceInSeconds = (endTimeNumber - startTimeNumber) * 60;
            saveRangeTime(differenceInSeconds);
          }),
      label: Text('Add Time Range'),
    );
  }
}

class ManualTimePicker extends StatefulWidget {
  final Function(int) saveManualTime;
  const ManualTimePicker({Key key, this.saveManualTime}) : super(key: key);

  @override
  _ManualTimePickerState createState() => _ManualTimePickerState();
}

class _ManualTimePickerState extends State<ManualTimePicker> {
  int hoursAdded;
  int minutesAdded;

  Future addManualTime(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Add Manual Time'),
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
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor)),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3)
                      ],
                      onChanged: (value) {
                        setState(() {
                          hoursAdded = int.parse(value);
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
                    child: TextField(
                      // TODO: add forced 0 to left if only 1 digit
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 50),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(5),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor)),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(2),
                        MinuteRangeTextInputFormatter()
                      ],
                      onChanged: (value) {
                        setState(() {
                          minutesAdded = int.parse(value);
                        });
                      },
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel')),
                TextButton(
                    onPressed: () {
                      widget.saveManualTime(hoursAdded * 60 + minutesAdded);
                      Navigator.pop(context);
                    },
                    child: Text('Ok')),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: Icon(Icons.more_time_rounded),
      onPressed: () => addManualTime(context),
      label: Text('Add Manual Time'),
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
