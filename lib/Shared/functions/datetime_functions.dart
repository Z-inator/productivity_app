import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DateTimeFunctions {
  DateTime timeStampToDateTime({Timestamp date}) {
    return date.toDate();
  }

  String dateToText({DateTime date}) {
    final String month = date.month.toString().padLeft(2, '0');
    final String day = date.day.toString().padLeft(2, '0');
    final String year = date.year.toString();
    final String hour = date.hour.toString().padLeft(2, '0');
    final String minute = date.minute.toString().padLeft(2, '0');
    return '$month/$day/$year - $hour:$minute';
  }

  String dateTimeToTextTime({DateTime date, BuildContext context}) {  // TODO: this is broken
    final TimeOfDay timeOfDay = TimeOfDay.fromDateTime(date);
    return timeOfDay.format(context);
  }

  String dateTimeToTextDate({DateTime date}) {
    return '${date.month}/${date.day}/${date.year}';
  }
}
