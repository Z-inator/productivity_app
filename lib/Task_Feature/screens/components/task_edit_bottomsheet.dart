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
import 'package:productivity_app/Task_Feature/screens/components/due_date/time_picker.dart';
import 'package:productivity_app/Task_Feature/screens/components/status_picker.dart';
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
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Due: '),
              DueDatePicker(
                saveDueDate: state.updateTaskDueDate,
                initialdate: state.newTask.dueDate,
              ),
              DueTimePicker(
                saveDueTime: state.updateTaskDueTime,
                initialdate: state.newTask.dueDate,
              )
            ],
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
