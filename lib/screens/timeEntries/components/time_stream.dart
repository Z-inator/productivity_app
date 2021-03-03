import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/services/projects_data.dart';
import 'package:productivity_app/services/times_data.dart';
import 'package:productivity_app/shared_components/color_functions.dart';
import 'package:productivity_app/shared_components/datetime_functions.dart';
import 'package:productivity_app/shared_components/time_functions.dart';
import 'package:provider/provider.dart';

class TimeStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: TimeService(user: user).timeEntries.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading');
            }
            return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                String day = document.id;
                String numberOfEntries =
                    document.data()['numberOfEntries'].toString();
                return Container(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 20),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    elevation: 10,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text(day), Text(numberOfEntries)],
                          ),
                        ),
                        Divider(),
                        DailyEntriesStream(day: day)
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}

class DailyEntriesStream extends StatefulWidget {
  final String day;
  DailyEntriesStream({this.day});

  @override
  _DailyEntriesStreamState createState() => _DailyEntriesStreamState();
}

class _DailyEntriesStreamState extends State<DailyEntriesStream> {

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: TimeService(user: user)
              .timeEntries
              .doc(widget.day)
              .collection('dayEntries')
              .orderBy('endTime', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading');
            }
            return ListBody(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                final String elapsedTime = TimeFunctions()
                    .timeToText(seconds: document.data()['elapsedTime']);
                final String entryName =
                    document.data()['entryName'].toString();
                final String projectName =
                    document.data()['projectName'].toString();
                final DateTime startTime =
                    DateTime.parse(document.data()['startTime'].toString());
                final DateTime endTime =
                    DateTime.parse(document.data()['endTime'].toString());
                final Color projectColor = ProjectColors().getColor(
                    colorSelector: ProjectService(user: user)
                        .getProjectColor(projectName: projectName));
                return ListTile(
                  leading: IconButton(
                      icon: Icon(Icons.play_arrow_rounded), onPressed: () {}),
                  title: Text(entryName),
                  subtitle: Text(
                    projectName,
                    style: TextStyle(color: projectColor),
                  ),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')} - ${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}'),
                      Text('$elapsedTime')
                    ],
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
