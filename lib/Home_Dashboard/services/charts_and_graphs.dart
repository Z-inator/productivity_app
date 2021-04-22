import 'package:flutter/cupertino.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:provider/provider.dart';

class TimeGraphs {
  List<DateTime> getCurrentWeek(DateTime referenceDay) {
    DateTime monday;
    DateTime sunday;
    for (var day = 0; day < 7; day++) {
      DateTime decreaseTemp = referenceDay.subtract(Duration(days: day));
      if (decreaseTemp.weekday == 1) {
        monday =
            DateTime(decreaseTemp.year, decreaseTemp.month, decreaseTemp.day);
      }
      DateTime increaseTemp = referenceDay.add(Duration(days: day));
      if (increaseTemp.weekday == 7) {
        sunday = DateTime(
            increaseTemp.year, increaseTemp.month, increaseTemp.day, 23, 59);
      }
    }
    return [monday, sunday];
  }

  List<Map<DateTime, int>> getTimeData(TimeService timeService,
      List<TimeEntry> timeEntries, DateTime startDay, DateTime endDay) {
    List<DateTime> days = [startDay, endDay];
    List<Map<DateTime, int>> recordedDailyTime = <Map<DateTime, int>>[];

    List<TimeEntry> timeData = timeEntries
        .where((entry) =>
            entry.endTime.isAfter(startDay) && entry.endTime.isBefore(endDay))
        .toList();
    if (timeData == null) {
      return null;
    } else {
      for (int i = 1; i < endDay.difference(startDay).inDays; i++) {
        days.add(startDay.add(Duration(days: i)));
      }
      days.sort((a, b) => a.compareTo(b));
      for (DateTime day in days) {
        int tempTotalTime = timeService.getRecordedTime(timeData, day);
        recordedDailyTime.add({day: tempTotalTime ?? 0});
      }
      return recordedDailyTime;
    }
  }

  double getMaxTime(List<Map<DateTime, int>> timeData) {
    double maxTime = 0;
    timeData.forEach((entry) {
      if (maxTime < entry.values.first) {
        maxTime = entry.values.first.toDouble();
      }
    });
    return maxTime;
  }

  int getTotalWeekTime(List<Map<DateTime, int>> timeData) {
    int totalWeekTime = 0;
    for (var entry in timeData) {
      totalWeekTime += entry.values.first;
    }
    return totalWeekTime;
  }
}

class TaskCharts {
  List<Task> getTasksDueToday(List<Task> tasks) {
    DateTime today = DateTime.now();
    return tasks
        .where((task) =>
            task.dueDate.year == today.year &&
            task.dueDate.month == today.month &&
            task.dueDate.day == today.day)
        .toList();
  }

  List<Task> getTasksDueThisWeek(List<Task> tasks) {
    DateTime today = DateTime.now();
    DateTime monday;
    DateTime sunday;
    for (var day = 0; day < 7; day++) {
      DateTime decreaseTemp = today.subtract(Duration(days: day));
      if (decreaseTemp.weekday == 1) {
        monday =
            DateTime(decreaseTemp.year, decreaseTemp.month, decreaseTemp.day);
      }
      DateTime increaseTemp = today.add(Duration(days: day));
      if (increaseTemp.weekday == 7) {
        sunday =
            DateTime(increaseTemp.year, increaseTemp.month, increaseTemp.day);
      }
    }
    return tasks
        .where((task) =>
            task.dueDate.isAfter(monday.subtract(Duration(days: 1))) &&
            task.dueDate.isBefore(sunday.add(Duration(days: 1))))
        .toList();
  }

  List<Task> getTasksPastDue(List<Task> tasks) {
    DateTime today = DateTime.now();
    return tasks
        .where((task) =>
            task.dueDate.isBefore(today) &&
            task.status.equalToComplete == false)
        .toList();
  }
}
