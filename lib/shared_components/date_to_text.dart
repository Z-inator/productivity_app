class DateText {
  final DateTime date;

  DateText({this.date});

  String dateToText() {
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');
    String year = date.year.toString();
    String hour = date.hour.toString().padLeft(2, '0');
    String minute = date.minute.toString().padLeft(2, '0');
    String returnedDate = '$month/$day/$year - $hour:$minute';
    return returnedDate;
  }
}
