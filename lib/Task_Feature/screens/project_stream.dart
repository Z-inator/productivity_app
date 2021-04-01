import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_expansion_tile.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Shared/color_functions.dart';
import 'package:productivity_app/Shared/time_functions.dart';
import 'package:provider/provider.dart';


class ProjectStream extends StatelessWidget {
  const ProjectStream({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Project> projects = Provider.of<List<Project>>(context) ?? [];
    return ListView(
        padding: EdgeInsets.only(bottom: 100),
        children: projects.map((project) {
          return Container(
              padding: EdgeInsets.all(10),
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  elevation: 5,
                  child: ProjectExpansionTile(project: project,)));
        }).toList());
  }
}


// class ProjectStream extends StatefulWidget {
//   @override
//   _ProjectStreamState createState() => _ProjectStreamState();
// }

// class _ProjectStreamState extends State<ProjectStream>
//     with AutomaticKeepAliveClientMixin {
//   @override
//   bool get wantKeepAlive => true;

//   @override
//   Widget build(BuildContext context) {
//     var projects = Provider.of<List<Project>>(context) ?? [];
//     return ListView(
//         padding: EdgeInsets.only(bottom: 100),
//         children: projects.map((project) {
//           return Container(
//               padding: EdgeInsets.all(10),
//               child: Card(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(25))),
//                   elevation: 5,
//                   child: Theme(
//                       data: Theme.of(context).copyWith(
//                           dividerColor: Colors.transparent,
//                           accentColor: Theme.of(context).unselectedWidgetColor),
//                       child: ExpansionTile(
//                         initiallyExpanded: false,
//                         leading: Icon(
//                           Icons.circle,
//                           color: Color(project.projectColor),
//                         ),
//                         title: Text(
//                           project.projectName,
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         trailing: IconButton(
//                             icon: Icon(Icons.edit_rounded),
//                             onPressed: () {
//                               showModalBottomSheet(
//                                   context: context,
//                                   isScrollControlled:
//                                       true, // Allows the modal to me dynamic and keeps the menu above the keyboard
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(25),
//                                           topRight: Radius.circular(25))),
//                                   builder: (BuildContext context) {
//                                     return ProjectEditBottomSheet(
//                                       project: project,
//                                     );
//                                   });
//                             }),
//                         children: [
//                           Container(
//                             margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text('Client: ${project.projectClient}',
//                                     style:
//                                         Theme.of(context).textTheme.subtitle1),
//                                 Text('Tasks: 10',
//                                     style:
//                                         Theme.of(context).textTheme.subtitle1),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                     'Time: ${TimeFunctions().timeToText(seconds: project.projectTime)}',
//                                     style:
//                                         Theme.of(context).textTheme.subtitle1),
//                                 OutlinedButton.icon(
//                                   icon: Icon(Icons.playlist_add_check_rounded),
//                                   label: Text(
//                                       'Tasks\n10'), // TODO: make this a live number
//                                   onPressed: () {
//                                     Navigator.pushNamed(context, '/taskscreen',
//                                         arguments: project.projectName);
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ))));
//         }).toList());
//   }
// }
