import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productivity_app/services/times_data.dart';
import 'package:productivity_app/shared_components/datetime_functions.dart';

class TimeEntry {
  String entryID;
  DateTime startTime;
  DateTime endTime;
  int elapsedTime;
  String entryName;
  String projectName;

  TimeEntry(
      {this.entryID,
      this.entryName,
      this.projectName,
      this.startTime,
      this.endTime,
      this.elapsedTime});

  // TODO: Entertain the idea of converting the timeEntries to a filtered distinct list instead of subCollections
  factory TimeEntry.fromFirestore(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    return TimeEntry(
        entryID: snapshot.id ?? '',
        entryName: data['entryName'].toString() ?? '',
        projectName: data['projectName'].toString() ?? '',
        startTime: DateTimeFunctions().timeStampToDateTime(date: data['startTime']) ?? DateTime.now(),
        endTime: DateTimeFunctions().timeStampToDateTime(date: data['endTime']) ?? DateTime.now(),
        elapsedTime: data['elapsedTime'] ?? 0);
  }
}
