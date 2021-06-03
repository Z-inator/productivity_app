import 'package:flutter/material.dart';

import '../../../Shared/Shared.dart';
import '../../../Task_Feature/Task_Feature.dart';

class StatusEditState extends ChangeNotifier {
  Status newStatus;
  final Status oldStatus;
  StatusEditState({this.oldStatus}) {
    if (oldStatus != null) {
      newStatus = oldStatus.copyStatus();
    } else {
      newStatus = Status();
    }
  }

  void updateStatus(Status status) {
    newStatus = status;
  }

  void updateStatusColor(int statusColor) {
    int index = AppColorList.indexWhere((color) => color.value == statusColor);
    newStatus.statusColor = index;
    notifyListeners();
  }

  void updateStatusComplete(bool equalToComplete) {
    newStatus.equalToComplete = equalToComplete;
    notifyListeners();
  }

  void updateStatusDescription(String statusDescription) {
    newStatus.statusDescription = statusDescription;
    notifyListeners();
  }

  void updateStatusName(String statusName) {
    newStatus.statusName = statusName;
    notifyListeners();
  }

  void updateStatusOrder(int statusOrder) {
    newStatus.statusOrder = statusOrder;
    notifyListeners();
  }
}
