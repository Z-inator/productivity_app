import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productivity_app/Shared/widgets/project_picker.dart';
import 'package:productivity_app/Shared/widgets/time_range_picker.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:productivity_app/Shared/widgets/hour_minute_picker.dart';
import 'package:productivity_app/Task_Feature/providers/task_edit_state.dart';
import 'package:productivity_app/Task_Feature/screens/components/status_picker.dart';
import 'package:productivity_app/Task_Feature/services/tasks_data.dart';
import 'package:provider/provider.dart';
import 'package:simple_time_range_picker/simple_time_range_picker.dart';

class TaskEditBottomSheet extends StatelessWidget {
  final Task task;
  final Project project;
  final Status status;
  // final bool isUpdate;

  const TaskEditBottomSheet(
      {Key key, this.task, this.project, this.status, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TaskEditState state = Provider.of<TaskEditState>(context);
    state.isUpdate ? state.updateTask(task) : state.addTask();
    if (project != null) {
      state.updateTaskProject(project);
    }
    if (status != null) {
      state.updateTaskStatus(status);
    }
    return Container(
        margin: EdgeInsets.all(20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(
            decoration: InputDecoration(
                hintText: state.isUpdate ? state.newTask.taskName : 'Enter Task Name'),
            textAlign: TextAlign.center,
            onChanged: (newText) {
              state.updateTaskName(newText);
            },
          ),
          ProjectPicker(
            saveProject: state.updateTaskProject, 
            child: ListTile(
              leading: Icon(
                Icons.circle,
                color: Color(
                    state.newTask.project.projectColor ?? 0x8A000000),
              ),
              title: Text(
                  state.newTask.project.projectName ?? 'Add Project',
                  style: Theme.of(context).textTheme.subtitle1),
              trailing: Icon(Icons.arrow_drop_down_rounded,
                  color: Theme.of(context).unselectedWidgetColor),
            ),
          ),
          StatusPicker(saveStatus: state.updateTaskStatus),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Due: ', style: Theme.of(context).textTheme.subtitle1),
              OutlinedButton.icon(
                onPressed: () => DateAndTimePickers().selectDate(
                  context: context, 
                  initialDate: state.newTask.dueDate.year != 0
                      ? state.newTask.dueDate 
                      : DateTime.now(), 
                  saveDate: state.updateTaskDueDate
                ),
                icon: Icon(Icons.today_rounded),
                label: Text(state.newTask.dueDate.year != 0
                    ? DateTimeFunctions().dateTimeToTextDate(date: state.newTask.dueDate)
                    : 'Add Due Date'),
              ),
              OutlinedButton.icon(
                onPressed: () => DateAndTimePickers().selectTime(context: context, initialTime: state.isUpdate ? TimeOfDay.fromDateTime(state.newTask.dueDate) : TimeOfDay.now(), saveTime: state.updateTaskDueTime),
                icon: Icon(Icons.alarm_rounded),
                label: Text(state.newTask.dueDate.hour != 0   // TODO: change to where you can set dueDate to midnight
                    ? DateTimeFunctions()
                        .dateTimeToTextTime(date: state.newTask.dueDate, context: context)
                    : 'Add Due Time'),
              ),
            ],
          ),
          // ListTile(
          //   title: Text(
          //     'Recorded Time: ${TimeFunctions().timeToText(seconds: Provider.of<TaskService>(context).getRecordedTime(context, task))}',
          //     style: Theme.of(context).textTheme.subtitle1),
          //   trailing: RangeTimePicker(),
          // ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton.icon(
                icon: Icon(Icons.check_circle_outline_rounded),
                label: Text(state.isUpdate ? 'Update' : 'Add'),
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
