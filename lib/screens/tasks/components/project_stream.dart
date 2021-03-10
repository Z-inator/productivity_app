import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  final _formKey = GlobalKey<FormState>();

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
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
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
                                        isScrollControlled:
                                            true, // Allows the modal to me dynamic and keeps the menu above the keyboard
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20))),
                                        builder: (BuildContext context) {
                                          return ProjectEditBottomSheet(
                                              projectName: projectName,
                                              projectColor: projectColor,
                                              projectClient: projectClient);
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
                                        label: Text('Tasks\n10'),
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

class ProjectEditBottomSheet extends StatefulWidget {
  const ProjectEditBottomSheet({
    Key key,
    @required this.projectName,
    @required this.projectColor,
    @required this.projectClient,
  }) : super(key: key);

  final String projectName;
  final Color projectColor;
  final String projectClient;

  @override
  _ProjectEditBottomSheetState createState() => _ProjectEditBottomSheetState();
}

class _ProjectEditBottomSheetState extends State<ProjectEditBottomSheet> {
  String newProjectName;
  String newClientName;
  Color newProjectColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration:
                InputDecoration(hintText: widget.projectName ?? 'Project Name'),
            textAlign: TextAlign.center,
            onChanged: (newText) {
              newProjectName = newText;
            },
          ),
          StatefulBuilder(
              builder: (BuildContext context, StateSetter modalSetState) {      // TODO: Iimplement side scrolling selector
            return Wrap(
              direction: Axis.horizontal,
              children: ProjectColors().colorList.map((color) {
                return Container(
                    decoration: BoxDecoration(
                        border: (newProjectColor ?? widget.projectColor) ==
                                Color(color)
                            ? Border.all(
                                color: Theme.of(context).primaryColor, width: 4)
                            : Border.all(color: Colors.transparent, width: 4),
                        borderRadius: BorderRadius.circular(4)),
                    child: IconButton(
                        icon: Icon(
                          Icons.circle,
                          color: Color(color),
                        ),
                        onPressed: () {
                          modalSetState(() {
                            newProjectColor = Color(color);
                            print(newProjectColor);
                          });
                        }));
              }).toList(),
            );
            // return PopupMenuButton(
            //   padding: EdgeInsets.symmetric(vertical: 20),
            //   icon: Icon(
            //     Icons.circle,
            //     color: newProjectColor ?? Colors.grey,
            //   ),
            //   itemBuilder: (context) {
            //     return ProjectColors()
            //         .colorList
            //         .map((color) => PopupMenuItem(
            //               child: Icon(
            //                 Icons.circle,
            //                 color: Color(color),
            //               ),
            //               value: color,
            //             ))
            //         .toList();
            //   },
            //   onSelected: (value) {
            //     setState(() {
            //       // print(Color(value));
            //       newProjectColor = Color(value);
            //       print(newProjectColor);
            //     });
            //   },
            // );
          }),
          TextField(
            decoration: InputDecoration(
                hintText: widget.projectClient ?? 'Client Name'),
            textAlign: TextAlign.center,
            onChanged: (newText) {
              newClientName = newText;
            },
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton.icon(
                icon: Icon(Icons.check_circle_outline_rounded),
                label: Text('Submit'),
                onPressed: () {},
              ))
        ],
      ),
    );
  }
}
