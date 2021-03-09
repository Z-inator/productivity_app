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
                final bool editMode = false;
                final String docID = document.id;
                final String projectName =
                    document.data()['projectName'].toString();
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
                          child: ProjectInfoExpansionTile(
                              projectColor: projectColor,
                              projectName: projectName,
                              editMode: editMode,
                              elapsedTime: elapsedTime),
                        )));
              }).toList());
        });
  }
}

class ProjectEditExpansionTile extends StatelessWidget {
  ProjectEditExpansionTile({
    Key key,
    @required this.projectColor,
    @required this.projectName,
    @required this.editMode,
    @required this.elapsedTime,
  }) : super(key: key);

  final Color projectColor;
  final String projectName;
  final bool editMode;
  final String elapsedTime;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ExpansionTile(
        initiallyExpanded: true,
        leading: IconButton(
          icon: Icon(Icons.circle),
          color: projectColor,
          onPressed: () {
            ProjectColors().colorSelector(context);
          },
        ),
        title: TextFormField(
          decoration: InputDecoration(hintText: projectName),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter a project name';
            }
            return null;
          },
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: IconButton(
          icon: Icon(Icons.check_circle_rounded), 
          onPressed: () {
            if (_formKey.currentState.validate()) {
              
            }
          }
        ),
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Time: $elapsedTime',
                    style: Theme.of(context).textTheme.subtitle1),
                Text('Tasks: 10', style: Theme.of(context).textTheme.subtitle1)
              ],
            ),
          ),
          OutlinedButton.icon(
            icon: Icon(Icons.playlist_add_check_rounded),
            label: Text('Tasks'),
            onPressed: () {
              Navigator.pushNamed(context, '/taskscreen', arguments: projectName);
            },
          ),
        ],
      ),
    );
  }
}

class ProjectInfoExpansionTile extends StatelessWidget {
  ProjectInfoExpansionTile({
    Key key,
    @required this.projectColor,
    @required this.projectName,
    @required this.editMode,
    @required this.elapsedTime,
  }) : super(key: key);

  final Color projectColor;
  final String projectName;
  final bool editMode;
  final String elapsedTime;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
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
            
          }),
      children: [
          Container(
            margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Client: ClientName', style: Theme.of(context).textTheme.subtitle1),
                
                Text('Tasks: 10', style: Theme.of(context).textTheme.subtitle1),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Time: $elapsedTime',
                    style: Theme.of(context).textTheme.subtitle1),
                OutlinedButton.icon(
                  icon: Icon(Icons.playlist_add_check_rounded),
                  label: Text('Tasks\n10'),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/taskscreen', arguments: projectName);
                  },
                ),
              ],
            ),
          ),
        ],
    );
  }
}
