import 'package:cloud_firestore/cloud_firestore.dart';

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
    String returnedDate = '$month/$day/$year - $hour:$minute';
    return returnedDate;
  }
}
