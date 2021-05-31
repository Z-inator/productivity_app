import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';

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

  void updateStatusName(String statusName) {
    newStatus.statusName = statusName;
    notifyListeners();
  }

  void updateStatusColor(int statusColor) {
    int index =
        AppColors.colorList.indexWhere((color) => color.value == statusColor);
    newStatus.statusColor = index;
    notifyListeners();
  }

  void updateStatusOrder(int statusOrder) {
    newStatus.statusOrder = statusOrder;
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
}
