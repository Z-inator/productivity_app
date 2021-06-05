import '../../../Task_Feature/Task_Feature.dart';
import '../../../Time_Feature/Time_Feature.dart';

class TimeGraphs {
  List<DateTime?> getCurrentWeek(DateTime referenceDay) {
    DateTime? monday;
    DateTime? sunday;
    for (var day = 0; day < 7; day++) {
      DateTime decreaseTemp = referenceDay.subtract(Duration(days: day));
      if (decreaseTemp.weekday == 1) {
        monday =
            DateTime(decreaseTemp.year, decreaseTemp.month, decreaseTemp.day);
      }
      DateTime increaseTemp = referenceDay.add(Duration(days: day));
      if (increaseTemp.weekday == 7) {
        sunday = DateTime(increaseTemp.year, increaseTemp.month,
            increaseTemp.day, 23, 59, 59, 999);
      }
    }
    return [monday, sunday];
  }

  List<DateTime> getDays(DateTime startDay, DateTime endDay) {
    int daysDifference = endDay.difference(startDay).inDays;
    List<DateTime> days = [startDay, endDay];
    DateTime temp = startDay;
    for (var i = 1; i < daysDifference; i++) {
      days.add(startDay.add(Duration(days: i)));
    }
    return days;
  }

  List<TimeEntry> getTimeRangeData(
      List<TimeEntry> timeEntries, DateTime? startDay, DateTime? endDay) {
    List<TimeEntry> timeData = timeEntries
        .where((entry) =>
            entry.endTime!.isAfter(startDay!) && entry.endTime!.isBefore(endDay!))
        .toList();
    return timeData;
  }

  List<Map<DateTime, int>> getTimeBarChartData(List<TimeEntry>? timeEntries, List<DateTime> days) {
    List<Map<DateTime, int>> recordedDailyTime = <Map<DateTime, int>>[];

    days.sort((a, b) => a.compareTo(b));

    for (DateTime day in days) {
      int tempTotalTime = int.parse(TimeService.getDailyRecordedTime(timeEntries!));
      recordedDailyTime.add({day: tempTotalTime});
    }
    return recordedDailyTime;
  }

  List<Map<Project, int>> getProjectPieChartData(List<TimeEntry> timeEntries) {
    List<Map<Project, int>> recordedProjectTime = <Map<Project, int>>[];
    List<Project> projects = getProjects(timeEntries);
    for (Project project in projects) {
      int projectTime = ProjectService.getRecordedTime(timeEntries
          .where((entry) => entry.project?.id == project.id)
          .toList());
      recordedProjectTime.add({project: projectTime});
    }
    return recordedProjectTime;
  }

  List<Project> getProjects(List<TimeEntry> timeEntries) {
    List<Project> projects = [];
    for (TimeEntry entry in timeEntries) {
      if (!projects.contains(entry.project)) {
        projects.add(entry.project!);
      }
    }
    return projects;
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

  int getTotalTimeRangeTime(List<TimeEntry> timeEntries) {
    int totalTime = 0;
    for (TimeEntry entry in timeEntries) {
      totalTime += entry.elapsedTime!;
    }
    return totalTime;
  }
}

class TaskCharts {
  List<Task> getTasksDueToday(List<Task> tasks) {
    DateTime today = DateTime.now();
    return tasks
        .where((task) =>
            task.dueDate?.year == today.year &&
            task.dueDate?.month == today.month &&
            task.dueDate?.day == today.day)
        .toList();
  }

  List<Task> getTasksDueThisWeek(List<Task> tasks) {
    DateTime today = DateTime.now();
    late DateTime monday;
    late DateTime sunday;
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
            task.dueDate!.isAfter(monday.subtract(Duration(days: 1))) &&
            task.dueDate!.isBefore(sunday.add(Duration(days: 1))))
        .toList();
  }

  List<Task> getTasksPastDue(List<Task> tasks) {
    DateTime today = DateTime.now();
    return tasks
        .where((task) =>
            task.dueDate!.isBefore(today) &&
            task.status!.equalToComplete == false)
        .toList();
  }
}
