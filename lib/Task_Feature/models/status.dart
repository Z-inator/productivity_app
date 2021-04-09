import 'package:cloud_firestore/cloud_firestore.dart';

class Status {
  String statusID = '';
  String statusName = '';
  int statusColor = 4285887861;
  int statusOrder = 0;

  Status({this.statusID, this.statusName, this.statusColor, this.statusOrder});

  factory Status.fromFirestore(DocumentSnapshot snapshot) {
    final Map data = snapshot.data();

    return Status(
      statusID: snapshot.id,
      statusName: data['statusName'].toString() ?? '',
      statusColor: data['statusColor'] as int ?? 4285887861,
      statusOrder: data['statusOrder'] as int ?? 0,
    );
  }
}
