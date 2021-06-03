import 'package:cloud_firestore/cloud_firestore.dart';

class Status {
  String id;
  String statusName;
  int statusColor;
  int statusOrder;
  bool equalToComplete;
  String statusDescription;

  Status({String id,
      String statusName,
      int statusColor,
      int statusOrder,
      bool equalToComplete,
      String statusDescription})
      : id = id ?? '',
        statusName = statusName ?? '',
        statusColor = statusColor ?? 4285887861,
        statusOrder = statusOrder ?? 0,
        equalToComplete = equalToComplete ?? false,
        statusDescription = statusDescription ?? '';

  factory Status.fromFirestore(DocumentSnapshot snapshot) {
    final Map data = snapshot.data() as Map<String, Object>;

    return Status(
        id: snapshot.id,
        statusName: data['statusName'].toString() ?? '',
        statusColor: data['statusColor'] as int ?? 4285887861,
        statusOrder: data['statusOrder'] as int ?? 0,
        equalToComplete: data['equalToComplete'] as bool ?? false,
        statusDescription: data['statusDescription'] as String ?? '');
  }

  Map<String, dynamic> toFirestore() {
    return {
      'statusName': statusName,
      'statusColor': statusColor,
      'statusOrder': statusOrder,
      'equalToComplete': equalToComplete,
      'statusDescription': statusDescription
    };
  }

  Status copyStatus() {
    return Status(
        id: id,
        statusName: statusName ?? '',
        statusColor: statusColor ?? 4285887861,
        statusOrder: statusOrder ?? 0,
        equalToComplete: equalToComplete ?? false,
        statusDescription: statusDescription ?? '');
  }
}
