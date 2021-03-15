import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/screens/tasks/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/services/projects_data.dart';
import 'package:productivity_app/shared_components/color_functions.dart';
import 'package:productivity_app/shared_components/time_functions.dart';
import 'package:provider/provider.dart';

class ProjectStream extends StatefulWidget {
  @override
  _ProjectStreamState createState() => _ProjectStreamState();
}

class _ProjectStreamState extends State<ProjectStream>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    return StreamBuilder<QuerySnapshot>(
        stream: ProjectService(user: user).projects.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text('Loading'));
          }
          return ListView(
              padding: EdgeInsets.only(bottom: 100),
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                final String docID = document.id;
                final String projectName =
                    document.data()['projectName'].toString();
                final String projectClient = 'Client';
                final Color projectColor = ProjectColors().getColor(
                    colorNumber:
                        int.parse(document.data()['projectColor'].toString()));
                final String elapsedTime = TimeFunctions().timeToText(
                    seconds:
                        int.parse(document.data()['projectTime'].toString()));
                return Container(
                    padding: EdgeInsets.all(10),
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        elevation: 5,
                        child: Theme(
                            data: Theme.of(context).copyWith(
                                dividerColor: Colors.transparent,
                                accentColor:
                                    Theme.of(context).unselectedWidgetColor),
                            child: ExpansionTile(
                              initiallyExpanded: false,
                              leading: Icon(
                                Icons.circle,
                                color: projectColor,
                              ),
                              title: Text(
                                projectName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              trailing: IconButton(
                                  icon: Icon(Icons.edit_rounded),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true, // Allows the modal to me dynamic and keeps the menu above the keyboard
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20))),
                                        builder: (BuildContext context) {
                                          return ProjectEditBottomSheet(
                                              projectName: projectName,
                                              projectColor: projectColor,
                                              projectClient: projectClient,
                                              projectID: docID,);
                                        });
                                  }),
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Client: ClientName',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1),
                                      Text('Tasks: 10',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Time: $elapsedTime',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1),
                                      OutlinedButton.icon(
                                        icon: Icon(
                                            Icons.playlist_add_check_rounded),
                                        label: Text('Tasks\n10'),   // TODO: make this a live number
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/taskscreen',
                                              arguments: projectName);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ))));
              }).toList());
        });
  }
}
