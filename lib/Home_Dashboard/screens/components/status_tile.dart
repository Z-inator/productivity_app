


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

class StatusEditPage extends StatefulWidget {
  StatusEditPage({Key key}) : super(key: key);

  @override
  _StatusEditPageState createState() => _StatusEditPageState();
}

class _StatusEditPageState extends State<StatusEditPage> {
  @override
  Widget build(BuildContext context) {
    List<Status> statuses = Provider.of<List<Status>>(context);
    StatusService statusService = Provider.of<StatusService>(context);
    return Container(
      child: ReorderableListView(
        children: statuses.map((status) {
          return ListTile(
            key: Key(status.statusID),
            leading: Icon(Icons.circle, color: Color(status.statusColor)),
            title: Text(status.statusName),
          );
        }).toList(),
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final Status statusTile = statuses.removeAt(oldIndex);
            statuses.insert(newIndex, statusTile);
            statusService.updateStatus(
                statusID: statusTile.statusID,
                updateData: {'statusOrder': newIndex});
          });
        },
      ),
    );
  }
}

