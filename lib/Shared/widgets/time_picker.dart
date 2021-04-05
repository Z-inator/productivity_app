import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';

class DueDatePicker extends StatelessWidget {
  final Function(DateTime) saveDueDate;
  final DateTime initialdate;
  const DueDatePicker({Key key, this.saveDueDate, this.initialdate})
      : super(key: key);

  Future selectDate(BuildContext context, DateTime initialDate) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: initialDate ?? DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2100));
    if (picked != null) {
      saveDueDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => selectDate(context, initialdate),
      icon: Icon(Icons.today_rounded),
      label: Text(DateTimeFunctions().dateTimeToTextDate(date: initialdate) ??
          'Add Due Date'),
    );
  }
}

class DueTimePicker extends StatelessWidget {
  final Function(TimeOfDay) saveDueTime;
  final DateTime initialdate;
  const DueTimePicker({Key key, this.saveDueTime, this.initialdate})
      : super(key: key);

  Future selectTime(BuildContext context, TimeOfDay initialTime) async {
    final TimeOfDay pickedTime = await showTimePicker(
        context: context, initialTime: initialTime ?? TimeOfDay.now());
    if (pickedTime != null) {
      saveDueTime(pickedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => selectTime(context, TimeOfDay.fromDateTime(initialdate)),
      icon: Icon(initialdate.hour == 0
          ? Icons.alarm_add_rounded
          : Icons.alarm_rounded),
      label: Text(initialdate.hour == 0
          ? 'Add Due Time'
          : DateTimeFunctions()
              .dateTimeToTextTime(date: initialdate, context: context)),
    );
  }
}
