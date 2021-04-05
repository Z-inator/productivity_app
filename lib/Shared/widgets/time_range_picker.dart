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
            DateTime day = DateTime.now();
            DateTime startTime = DateTime(day.year, day.month, day.day, value.startTime.hour, value.startTime.minute);
            DateTime endTime = DateTime(day.year, day.month, day.day, value.endTime.hour, value.endTime.minute);
            Duration difference = endTime.difference(startTime);
            int seconds = difference.inSeconds;
            saveRangeTime(seconds);
          }),
    );
  }
}