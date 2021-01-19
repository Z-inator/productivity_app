class DueTaskHeader {
  bool isExpanded;
  String header;
  DueTaskBody dueTaskBody;

  DueTaskHeader({this.isExpanded, this.header, this.dueTaskBody});
}

class DueTaskBody {
  String taskName;
  String projectName;
  String trackedTime;

  DueTaskBody({this.taskName, this.projectName, this.trackedTime});
}
