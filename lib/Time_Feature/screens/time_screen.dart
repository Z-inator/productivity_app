import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/widgets/project_picker.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/screens/time_entries_by_day.dart';
import 'package:provider/provider.dart';



class TimeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<TimeEntry> timeEntries = Provider.of<List<TimeEntry>>(context);
    return Column(
      children: [
        ProjectPicker(
          child: ListTile(
            title: Text('Sort by Project'),
          ),
        ),
        Expanded(child: TimeEntriesByDay(timeEntries: timeEntries))
      ],
    );
  }
}
