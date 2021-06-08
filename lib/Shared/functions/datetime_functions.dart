import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DateTimeFunctions {
  DateTime timeStampToDateTime({required Timestamp date}) {
    return date.toDate();
  }

  String? dateToText({required DateTime? date}) {
    if (date == null) {
      return null;
    }
    final String month = date.month.toString().padLeft(2, '0');
    final String day = date.day.toString().padLeft(2, '0');
    final String year = date.year.toString();
    final String hour = date.hour.toString().padLeft(2, '0');
    final String minute = date.minute.toString().padLeft(2, '0');
    return '$month/$day/$year - $hour:$minute';
  }

  String? dateTimeToTextTime(
      {required DateTime? date, required BuildContext context}) {
    // TODO: this is broken
    if (date == null) {
      return null;
    }
    final TimeOfDay timeOfDay = TimeOfDay.fromDateTime(date);
    return timeOfDay.format(context);
  }

  String? dateTimeToTextDate({required DateTime? date}) {
    if (date == null) {
      return null;
    }
    return '${date.month}/${date.day}/${date.year}';
  }

  String timeToText({required int seconds}) {
    final String hourStr =
        (seconds / (60 * 60)).floor().toString().padLeft(2, '0');
    final String minutesStr =
        ((seconds / 60) % 60).floor().toString().padLeft(2, '0');
    final String secondsStr = (seconds % 60).floor().toString().padLeft(2, '0');
    return '$hourStr:$minutesStr:$secondsStr';
  }

  // String timeOfDayToText({TimeOfDay time, BuildContext context}) {
  //   return time.format(context);
  // }

  String timeToTextWithoutSeconds({required int seconds}) {
    final String hourStr =
        ((seconds / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
    final String minutesStr =
        ((seconds / 60) % 60).floor().toString().padLeft(2, '0');
    return '$hourStr:$minutesStr';
  }

  String timeToTextHours({required int seconds}) {
    return ((seconds / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
  }

  String timeToTextMinutes({required int seconds}) {
    return ((seconds / 60) % 60).floor().toString().padLeft(2, '0');
  }

  String timeToTextSeconds({required int seconds}) {
    return (seconds % 60).floor().toString().padLeft(2, '0');
  }
}
