import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DateTimeFunctions {
  DateTime timeStampToDateTime({Timestamp date}) {
    return date.toDate();
  }

  String dateToText({DateTime date}) {
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');
    String year = date.year.toString();
    String hour = date.hour.toString().padLeft(2, '0');
    String minute = date.minute.toString().padLeft(2, '0');
    return '$month/$day/$year - $hour:$minute';
  }

  String dateTimeToTextTime({DateTime date, BuildContext context}) {
    final TimeOfDay timeOfDay = TimeOfDay.fromDateTime(date);
    return timeOfDay.format(context);
  }

  String dateTimeToTextDate({DateTime date}) {
    return '${date.month}/${date.day}/${date.year}';
  }
}
