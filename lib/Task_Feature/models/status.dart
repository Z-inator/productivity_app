import 'package:cloud_firestore/cloud_firestore.dart';

class Status {
  String statusID;
  String statusName;
  int statusColor;
  int statusOrder;
  bool equalToComplete;

  Status({statusID, statusName, statusColor, statusOrder, equalToComplete})
      : statusID = statusID as String ?? '',
        statusName = statusName as String ?? '',
        statusColor = statusColor as int ?? 4285887861,
        statusOrder = statusOrder as int ?? 0,
        equalToComplete = equalToComplete as bool ?? false;

  factory Status.fromFirestore(DocumentSnapshot snapshot) {
    final Map data = snapshot.data();

    return Status(
        statusID: snapshot.id,
        statusName: data['statusName'].toString() ?? '',
        statusColor: data['statusColor'] as int ?? 4285887861,
        statusOrder: data['statusOrder'] as int ?? 0,
        equalToComplete: data['equalToComplete'] as bool ?? false);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'statusName': statusName,
      'statusColor': statusColor,
      'statusOrder': statusOrder,
      'equalToComplete': equalToComplete
    };
  }

  Status copyStatus() {
    return Status(
        statusID: statusID,
        statusName: statusName ?? '',
        statusColor: statusColor ?? 4285887861,
        statusOrder: statusOrder ?? 0,
        equalToComplete: equalToComplete ?? false);
  }
}
