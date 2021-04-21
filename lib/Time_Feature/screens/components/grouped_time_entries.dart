import 'package:flutter/material.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/screens/components/time_entry_expansion_tile.dart';

class GroupedTimeEntries extends StatelessWidget {
  final List<TimeEntry> timeEntries;
  const GroupedTimeEntries({Key key, this.timeEntries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return timeEntries == null
        ? Center(child: CircularProgressIndicator())
        : timeEntries.isEmpty
            ? Center(child: Text('Record Time Worked to View Here.'))
            : ListBody(
                children: timeEntries.map((entry) {
                  return TimeEntryExpansionTile(entry: entry);
                }).toList(),
              );
  }
}

