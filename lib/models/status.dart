import 'package:cloud_firestore/cloud_firestore.dart';

class Status {
  String statusID;
  String statusName;
  int statusColor;
  int statusOrder;

  Status({this.statusID, this.statusName, this.statusColor, this.statusOrder});

  factory Status.fromFirestore(DocumentSnapshot snapshot) {
    Map data = snapshot.data();

    return Status(
      statusID: snapshot.id,
      statusName: data['statusName'].toString() ?? '',
      statusColor: data['statusColor'] ?? 4285887861,
      statusOrder: data['statusOrder'] ?? 0,
    );
  }
}
