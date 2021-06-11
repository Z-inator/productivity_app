import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/Shared.dart';
import 'package:simple_time_range_picker/simple_time_range_picker.dart';

class DateAndTimePickers {
  
  Future selectDate({required BuildContext context, DateTime? initialDate, Function(DateTime)? saveDate}) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDate ?? DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2100));
    if (picked != null) {
      saveDate!(picked);
    }
  }

  Future selectTime({required BuildContext context, TimeOfDay? initialTime, Function(TimeOfDay)? saveTime}) async {
    final TimeOfDay? pickedTime = await showTimePicker(
        context: context, initialTime: initialTime ?? TimeOfDay.now());
    if (pickedTime != null) {
      saveTime!(pickedTime);
    }
  }

  TimeRangePicker buildTimeRangePicker({required BuildContext context, Function(TimeRangeValue)? saveTimeRange}) {
    return TimeRangePicker.show(
        context: context,
        onSubmitted: (TimeRangeValue value) {
          saveTimeRange!(value);
          // final DateTime day = DateTime.now();
          // final DateTime startTime = DateTime(day.year, day.month, day.day, value.startTime.hour, value.startTime.minute);
          // final DateTime endTime = DateTime(day.year, day.month, day.day, value.endTime.hour, value.endTime.minute);
          // final Duration difference = endTime.difference(startTime);
          // final int seconds = difference.inSeconds;
          // saveTimeRange(seconds);
        });
  }
}
