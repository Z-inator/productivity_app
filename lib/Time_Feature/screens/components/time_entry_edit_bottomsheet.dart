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
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/providers/time_entry_edit_state.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:provider/provider.dart';
import 'package:simple_time_range_picker/simple_time_range_picker.dart';

class TimeEntryEditBottomSheet extends StatelessWidget {
  final bool isUpdate;
  final TimeEntry entry;
  final Project project;
  final Task task;

  TimeEntryEditBottomSheet(
      {Key key, this.isUpdate, this.entry, this.project, this.task})
      : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TimeEntryEditState(),
      builder: (context, child) {
        final TimeEntryEditState state =
            Provider.of<TimeEntryEditState>(context);
        if (entry != null) {
          state.updateEntry(entry);
        }
        if (project != null) {
          state.updateEntryProject(project);
        }
        if (task != null) {
          state.updateEntryTask(task);
        }
        return Container(
            margin: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter an Entry Name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: state.newEntry.entryName.isEmpty
                          ? 'Enter Time Entry Name'
                          : state.newEntry.entryName),
                  textAlign: TextAlign.center,
                  onChanged: (newText) {
                    state.updateEntryName(newText);
                  },
                ),
                ProjectPicker(
                  saveProject: state.updateEntryProject,
                  child: ListTile(
                    leading: Icon(
                      Icons.circle,
                      color: Color(state.newEntry.project.projectColor),
                    ),
                    title: Text(
                        state.newEntry.project.projectName.isEmpty
                            ? 'Add Project'
                            : state.newEntry.project.projectName,
                        style: Theme.of(context).textTheme.subtitle1),
                    trailing: Icon(Icons.arrow_drop_down_rounded,
                        color: Theme.of(context).unselectedWidgetColor),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Date:    ',
                        style: Theme.of(context).textTheme.subtitle1),
                    OutlinedButton.icon(
                        onPressed: () => DateAndTimePickers().selectDate(
                            context: context,
                            initialDate: isUpdate
                                ? state.newEntry.startTime
                                : DateTime.now(),
                            saveDate: state.updateDate),
                        icon: Icon(Icons.today_rounded),
                        label: Text(DateTimeFunctions().dateTimeToTextDate(
                            date: state.newEntry.startTime))),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Time:    ',
                        style: Theme.of(context).textTheme.subtitle1),
                    OutlinedButton.icon(
                        onPressed: () => DateAndTimePickers()
                            .buildTimeRangePicker(
                                context: context,
                                saveTimeRange: state.updateStartEndTime),
                        icon: Icon(Icons.timelapse_rounded),
                        label: Text(
                            '${TimeOfDay.fromDateTime(state.newEntry.startTime).format(context)} - ${TimeOfDay.fromDateTime(state.newEntry.endTime).format(context)}'))
                  ],
                ),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.check_circle_outline_rounded),
                      label: Text(isUpdate ? 'Update' : 'Add'),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          isUpdate
                              ? TimeService().updateTimeEntry(
                                  timeEntryID: entry.entryID,
                                  updateData: state.newEntry.toFirestore())
                              : TimeService().addTimeEntry(
                                  addData: state.newEntry.toFirestore());
                          Navigator.pop(context);
                        }
                      },
                    ))
              ]),
            ));
      },
    );
  }
}
