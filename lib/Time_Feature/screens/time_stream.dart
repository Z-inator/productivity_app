import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Time_Feature/screens/components/grouped_time_entries.dart';
import 'package:productivity_app/Time_Feature/screens/time_entries_by_day.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:provider/provider.dart';


class TimeStream extends StatelessWidget {
  const TimeStream({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TimeEntry> timeEntries = Provider.of<List<TimeEntry>>(context);

    return timeEntries == null
        ? Center(child: CircularProgressIndicator())
        : TimeEntriesByDay(timeEntries: timeEntries);
  }
}


