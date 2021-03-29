import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/models/status.dart';
import 'package:productivity_app/services/statuses_data.dart';
import 'package:productivity_app/shared_components/color_functions.dart';
import 'package:productivity_app/shared_components/time_functions.dart';
import 'package:provider/provider.dart';

class StatusEditBottomSheet extends StatefulWidget {
  final Status status;

  StatusEditBottomSheet({this.status});

  @override
  _StatusEditBottomSheetState createState() => _StatusEditBottomSheetState();
}

class _StatusEditBottomSheetState extends State<StatusEditBottomSheet> {
  String newStatusName;
  Color newStatusColor;
  int newStatusColorValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration:
                InputDecoration(hintText: widget.status.statusName ?? 'Status Name'),
            textAlign: TextAlign.center,
            onChanged: (newText) {
              newStatusName = newText;
            },
          ),
          StatefulBuilder(
              builder: (BuildContext context, StateSetter modalSetState) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ProjectColors().colorList.map((color) {
                  return IconButton(
                      icon: (newStatusColor ?? Color(widget.status.statusColor)) ==
                              Color(color)
                          ? Icon(
                              Icons.check_circle_rounded,
                              color: Color(color),
                              size: 36,
                            )
                          : Icon(
                              Icons.circle,
                              color: Color(color),
                              size: 36,
                            ),
                      onPressed: () {
                        modalSetState(() {
                          newStatusColor = Color(color);
                        });
                      });
                }).toList(),
              ),
            );
          }),
          Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton.icon(
                icon: Icon(Icons.check_circle_outline_rounded),
                label: Text('Submit'),
                onPressed: () {
                  StatusService()
                      .updateStatus(statusID: widget.status.statusID, updateData: {
                    'statusName': newStatusName ?? widget.status.statusName,
                    'statusColor': int.parse(
                            '0x${newStatusColor.value.toRadixString(16).toUpperCase().toString()}') ??
                        int.parse('0x${widget.status.statusColor.toString()}')
                  });
                  Navigator.pop(context);
                },
              ))
        ],
      ),
    );
  }
}
