


import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/screens/components/status_expansion_tile.dart';
import 'package:productivity_app/Task_Feature/services/statuses_data.dart';
import 'package:provider/provider.dart';

class StatusList extends StatelessWidget {
  const StatusList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Status> statuses = Provider.of<List<Status>>(context);

    return statuses == null
        ? Center(child: CircularProgressIndicator())
        : statuses.isEmpty
            ? Center(child: Text('Add Statuses to view here'),)
            : Container(
                child: ListBody(
                children: statuses.map((status) {
                  return StatusExpansionTile(status: status);
                }).toList(),
              ));
  }
}

