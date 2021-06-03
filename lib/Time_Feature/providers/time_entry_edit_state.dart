import 'package:flutter/material.dart';
import 'package:simple_time_range_picker/simple_time_range_picker.dart';

import '../../../Task_Feature/Task_Feature.dart';
import '../../../Time_Feature/Time_Feature.dart';

class TimeEntryEditState extends ChangeNotifier {
  late TimeEntry newEntry;
  final TimeEntry? oldEntry;

  TimeEntryEditState({this.oldEntry}) {
    if (oldEntry != null) {
      newEntry = oldEntry!.copyTimeEntry();
    } else {
      newEntry = TimeEntry();
    }
  }

  void updateEntry(TimeEntry entry) {
    newEntry = entry;
  }

  void updateEntryName(String entryName) {
    newEntry.entryName = entryName;
    notifyListeners();
  }

  void updateEntryProject(Project project) {
    newEntry.project = project;
    notifyListeners();
  }

  void updateEntryTask(Task task) {
    newEntry.task = task;
    notifyListeners();
  }

  void updateDate(DateTime date) {
    newEntry.startTime = DateTime(date.year, date.month, date.day,
        newEntry.startTime.hour, newEntry.startTime.minute);
    newEntry.endTime = DateTime(date.year, date.month, date.day,
        newEntry.endTime.hour, newEntry.endTime.minute);
    notifyListeners();
  }

  void updateStartEndTime(TimeRangeValue timeRangeValue) {
    newEntry.startTime = DateTime(
        newEntry.startTime.year,
        newEntry.startTime.month,
        newEntry.startTime.day,
        timeRangeValue.startTime.hour,
        timeRangeValue.startTime.minute);
    newEntry.endTime = DateTime(
        newEntry.endTime.year,
        newEntry.endTime.month,
        newEntry.endTime.day,
        timeRangeValue.endTime.hour,
        timeRangeValue.endTime.minute);
    notifyListeners();
  }
}
