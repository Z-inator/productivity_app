import 'package:flutter/material.dart';
import 'package:simple_time_range_picker/simple_time_range_picker.dart';

class RangeTimePicker extends StatelessWidget {
  final Function(int) saveRangeTime;
  const RangeTimePicker({Key key, this.saveRangeTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.timelapse_rounded, color: Theme.of(context).unselectedWidgetColor,),
      tooltip: 'Add Time Entry',
      onPressed: () => TimeRangePicker.show(
          context: context,
          onSubmitted: (TimeRangeValue value) {
            final DateTime day = DateTime.now();
            final DateTime startTime = DateTime(day.year, day.month, day.day, value.startTime.hour, value.startTime.minute);
            final DateTime endTime = DateTime(day.year, day.month, day.day, value.endTime.hour, value.endTime.minute);
            final Duration difference = endTime.difference(startTime);
            final int seconds = difference.inSeconds;
            saveRangeTime(seconds);
          }),
    );
  }
}