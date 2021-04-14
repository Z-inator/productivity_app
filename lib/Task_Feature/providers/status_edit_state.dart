import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';

class StatusEditState with ChangeNotifier {
  Status newStatus;
  StatusEditState() : newStatus = Status();

  void updateStatus(Status status) {
    newStatus = status;
  }

  void updateStatusName(String statusName) {
    newStatus.statusName = statusName;
    notifyListeners();
  }

  void updateStatusColor(int statusColor) {
    newStatus.statusColor = statusColor;
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
}
