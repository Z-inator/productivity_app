import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productivity_app/Shared/widgets/project_picker.dart';
import 'package:productivity_app/Shared/widgets/date_and_time_pickers.dart';
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
  final bool isUpdate;
  final Task task;
  final Project project;
  final Status status;

  const TaskEditBottomSheet({
    Key key,
    this.isUpdate,
    this.task,
    this.project,
    this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskEditState(),
      builder: (context, child) {
        final TaskEditState state = Provider.of<TaskEditState>(context);
        final TaskService taskService = Provider.of<TaskService>(context);
        if (task != null) {
          state.updateTask(task);
        }
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
                    hintText: state.newTask.taskName.isEmpty
                        ? 'Enter Task Name'
                        : state.newTask.taskName),
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
                    color: Color(state.newTask.project.projectColor),
                  ),
                  title: Text(
                      state.newTask.project.projectName.isEmpty
                          ? 'Add Project'
                          : state.newTask.project.projectName,
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
                        initialDate: state.newTask.dueDate.year == 0
                            ? DateTime.now()
                            : state.newTask.dueDate,
                        saveDate: state.updateTaskDueDate),
                    icon: Icon(Icons.today_rounded),
                    label: Text(state.newTask.dueDate.year == 0
                        ? 'Add Due Date'
                        : DateTimeFunctions()
                            .dateTimeToTextDate(date: state.newTask.dueDate)),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => DateAndTimePickers().selectTime(
                        context: context,
                        initialTime: state.newTask.dueDate.hour == 0
                            ? TimeOfDay.now()
                            : TimeOfDay.fromDateTime(state.newTask.dueDate),
                        saveTime: state.updateTaskDueTime),
                    icon: Icon(Icons.alarm_rounded),
                    label: Text(state.newTask.dueDate.hour !=
                            0 // TODO: change to where you can set dueDate to midnight
                        ? DateTimeFunctions().dateTimeToTextTime(
                            date: state.newTask.dueDate, context: context)
                        : 'Add Due Time'),
                  ),
                ],
              ),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton.icon(
                        icon: Icon(Icons.cancel_rounded),
                        label: Text('Cancel'),
                        onPressed: () {
                          // state.disposeOfState();
                          Navigator.pop(context);
                        },
                      ),
                      ElevatedButton.icon(
                        icon: Icon(Icons.check_circle_outline_rounded),
                        label: Text(isUpdate ? 'Update' : 'Add'),
                        onPressed: () {
                          isUpdate
                              ? taskService.updateTask(
                                  taskID: task.taskID,
                                  updateData: state.newTask.toFirestore())
                              : taskService.addTask(
                                  addData: state.newTask.toFirestore());
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ))
            ]));
      },
    );
  }
}
