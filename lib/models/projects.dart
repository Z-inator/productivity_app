import 'package:productivity_app/models/colors.dart';


class Projects {
  String projectID;
  String projectName;
  // TODO double check what variable type this needs to be
  ProjectColors projectColor;
  // TODO learn about date/time
  int projectTime = 0;
  List<String> taskList = [];

  Projects({this.projectID, this.projectName, this.projectColor});
}
