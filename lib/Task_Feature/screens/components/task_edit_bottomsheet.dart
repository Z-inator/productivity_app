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

  TaskEditBottomSheet({
    Key key,
    this.isUpdate,
    this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskEditState(oldTask: task),
      builder: (context, child) {
        final TaskEditState taskEditState = Provider.of<TaskEditState>(context);
        final TaskService taskService = Provider.of<TaskService>(context);
        return Container(
            margin: EdgeInsets.all(20),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextField(
                controller: TextEditingController(text: taskEditState.newTask.taskName),
                decoration: InputDecoration(
                    hintText: taskEditState.newTask.taskName.isEmpty
                        ? 'Enter Task Name'
                        : taskEditState.newTask.taskName),
                textAlign: TextAlign.center,
                onChanged: (newText) {
                  taskEditState.updateTaskName(newText);
                },
              ),
              ProjectPicker(
                saveProject: taskEditState.updateTaskProject,
                child: ListTile(
                  leading: Icon(
                    Icons.topic_rounded,
                    color: Color(taskEditState.newTask.project.projectColor),
                  ),
                  title: Text(
                      taskEditState.newTask.project.projectName.isEmpty
                          ? 'Add Project'
                          : taskEditState.newTask.project.projectName,
                      style: Theme.of(context).textTheme.subtitle1),
                  trailing: Icon(Icons.arrow_drop_down_rounded,
                      color: Theme.of(context).unselectedWidgetColor),
                ),
              ),
              StatusPicker(saveStatus: taskEditState.updateTaskStatus, task: taskEditState.newTask),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Due: ', style: Theme.of(context).textTheme.subtitle1),
                  OutlinedButton.icon(
                    onPressed: () => DateAndTimePickers().selectDate(
                        context: context,
                        initialDate: taskEditState.newTask.dueDate.year == 1
                            ? DateTime.now()
                            : taskEditState.newTask.dueDate,
                        saveDate: taskEditState.updateTaskDueDate),
                    icon: Icon(Icons.today_rounded),
                    label: Text(taskEditState.newTask.dueDate.year == 1
                        ? 'Add Due Date'
                        : DateTimeFunctions().dateTimeToTextDate(
                            date: taskEditState.newTask.dueDate)),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => DateAndTimePickers().selectTime(
                        context: context,
                        initialTime:
                            taskEditState.newTask.dueDate.microsecond == 555
                                ? TimeOfDay.now()
                                : TimeOfDay.fromDateTime(
                                    taskEditState.newTask.dueDate),
                        saveTime: taskEditState.updateTaskDueTime),
                    icon: Icon(Icons.alarm_rounded),
                    label: Text(taskEditState.newTask.dueDate.microsecond != 555
                        ? DateTimeFunctions().dateTimeToTextTime(
                            date: taskEditState.newTask.dueDate,
                            context: context)
                        : 'Add Due Time'),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child:
                    ElevatedButton.icon(
                  icon: Icon(Icons.check_circle_outline_rounded),
                  label: Text(isUpdate ? 'Update' : 'Add'),
                  onPressed: () {
                    isUpdate
                          ? taskService.updateTask(
                              taskID: task.taskID,
                              updateData: taskEditState.newTask.toFirestore())
                          : taskService.addTask(
                              addData: taskEditState.newTask.toFirestore());
                      Navigator.pop(context);
                    }
                ),
              )
            ]));
      },
    );
  }
}


// class TaskEditBottomSheet extends StatefulWidget {
//   final bool isUpdate;
//   final Task task;

//   TaskEditBottomSheet({
//     Key key,
//     this.isUpdate,
//     this.task,
//   }) : super(key: key);

//   @override
//   _TaskEditBottomSheetState createState() => _TaskEditBottomSheetState();
// }

// class _TaskEditBottomSheetState extends State<TaskEditBottomSheet> {
//   Task newTask = Task();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   void updateProject(Project project) {
//     setState(() {
//       newTask.project = project;
//     });
//   }

//   void updateStatus(Status status) {
//     setState(() {
//       newTask.status = status;
//     });
//   }

//   void updateTaskDueDate(DateTime dueDate) {
//     if (newTask.dueDate.microsecond == 555) {
//       newTask.dueDate = dueDate;
//     } else {
//       final DateTime temp = newTask.dueDate;
//       newTask.dueDate = DateTime(
//           dueDate.year, dueDate.month, dueDate.day, temp.hour, temp.minute);
//     }
//   }

//   void updateTaskDueTime(TimeOfDay dueTime) {
//     if (newTask.dueDate.year == 0) {
//       newTask.dueDate = DateTime(0, 0, 0, dueTime.hour, dueTime.minute);
//     } else {
//       final DateTime temp = newTask.dueDate;
//       newTask.dueDate = DateTime(
//           temp.year, temp.month, temp.day, dueTime.hour, dueTime.minute);
//     }
//   }

//   @override
//   void initState() {
//     if (widget.task != null) {
//       newTask = widget.task;
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final TaskService taskService = Provider.of<TaskService>(context);
//     return SafeArea(
//           child: Scaffold(
//             appBar: AppBar(
//               title: Text(newTask.taskName.isEmpty
//                             ? 'Add Task'
//                             : newTask.taskName),
//             ),
//                       body: Container(
//                 margin: EdgeInsets.all(20),
//                 child: Column(mainAxisSize: MainAxisSize.min, children: [
//                   TextFormField(
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please Enter Task Name';
//                       }
//                       return null;
//                     },
//                     decoration: InputDecoration(
//                         hintText: newTask.taskName.isEmpty
//                             ? 'Enter Task Name'
//                             : newTask.taskName),
//                     textAlign: TextAlign.center,
//                     onChanged: (newText) {
//                       newTask.taskName = newText;
//                     },
//                   ),
//                   ProjectPicker(
//                     saveProject: updateProject,
//                     child: ListTile(
//                       leading: Icon(
//                         Icons.circle,
//                         color: Color(newTask.project.projectColor),
//                       ),
//                       title: Text(
//                           newTask.project.projectName.isEmpty
//                               ? 'Add Project'
//                               : newTask.project.projectName,
//                           style: Theme.of(context).textTheme.subtitle1),
//                       trailing: Icon(Icons.arrow_drop_down_rounded,
//                           color: Theme.of(context).unselectedWidgetColor),
//                     ),
//                   ),
//                   StatusPicker(saveStatus: updateStatus, task: newTask),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Text('Due: ', style: Theme.of(context).textTheme.subtitle1),
//                       OutlinedButton.icon(
//                         onPressed: () => DateAndTimePickers().selectDate(
//                             context: context,
//                             initialDate: newTask.dueDate.year == 1
//                                 ? DateTime.now()
//                                 : newTask.dueDate,
//                             saveDate: updateTaskDueDate),
//                         icon: Icon(Icons.today_rounded),
//                         label: Text(newTask.dueDate.year == 1
//                             ? 'Add Due Date'
//                             : DateTimeFunctions().dateTimeToTextDate(
//                                 date: newTask.dueDate)),
//                       ),
//                       OutlinedButton.icon(
//                         onPressed: () => DateAndTimePickers().selectTime(
//                             context: context,
//                             initialTime:
//                                 newTask.dueDate.microsecond == 555
//                                     ? TimeOfDay.now()
//                                     : TimeOfDay.fromDateTime(
//                                         newTask.dueDate),
//                             saveTime: updateTaskDueTime),
//                         icon: Icon(Icons.alarm_rounded),
//                         label: Text(newTask.dueDate.microsecond != 555
//                             ? DateTimeFunctions().dateTimeToTextTime(
//                                 date: newTask.dueDate,
//                                 context: context)
//                             : 'Add Due Time'),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(vertical: 20),
//                     child:
//                         ElevatedButton.icon(
//                       icon: Icon(Icons.check_circle_outline_rounded),
//                       label: Text(widget.isUpdate ? 'Update' : 'Add'),
//                       onPressed: () {
//                         if (_formKey.currentState.validate()) {
//                           widget.isUpdate
//                               ? taskService.updateTask(
//                                   taskID: widget.task.taskID,
//                                   updateData: newTask.toFirestore())
//                               : taskService.addTask(
//                                   addData: newTask.toFirestore());
//                           Navigator.pop(context);
//                         }
//                       },
//                     ),
//                   )
//                 ])),
//           ),
//     );
//   }
// }
// 