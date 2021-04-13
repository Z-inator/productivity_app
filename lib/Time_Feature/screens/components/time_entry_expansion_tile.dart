import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:productivity_app/Shared/widgets/date_and_time_pickers.dart';
import 'package:productivity_app/Shared/widgets/edit_bottom_sheets.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/screens/components/time_entry_edit_bottomsheet.dart';

class TimeEntryExpansionTile extends StatelessWidget {
  final TimeEntry entry;
  const TimeEntryExpansionTile({Key key, this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: IconButton(
          icon: Icon(Icons.play_arrow_rounded),
          color: Colors.green,
          onPressed: () {}),
      title: Text(entry.entryName),
      subtitle: Text(entry.project.projectName,
          style: TextStyle(color: Color(entry.project.projectColor))),
      trailing: Text(TimeFunctions().timeToText(seconds: entry.elapsedTime)),
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Time:     '),
              Text(DateTimeFunctions()
                  .dateTimeToTextTime(date: entry.startTime, context: context)),
              Text(' - '),
              Text(DateTimeFunctions()
                  .dateTimeToTextTime(date: entry.endTime, context: context)),
            ],
          ),
        ),
        Container(
          child: IconButton(icon: Icon(Icons.edit_rounded), onPressed: () => EditBottomSheet().buildEditBottomSheet(
                  context: context, 
                  bottomSheet: TimeEntryEditBottomSheet(isUpdate: true, entry: entry))),
        )
      ],
    );
  }
}
