import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Task_Feature/Task_Feature.dart';

class StatusList extends StatelessWidget {
  const StatusList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Status> statuses = Provider.of<List<Status>>(context);
    return statuses == null
        ? Center(child: CircularProgressIndicator())
        : Column(
          mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Statuses',
                    style:
                        DynamicColorTheme.of(context).data.textTheme.headline4),
                trailing: IconButton(
                  icon: Icon(Icons.edit_rounded),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StatusEditPage(),
                        ));
                  },
                ),
              ),
              statuses.isEmpty
                  ? Center(
                      child: Text('Add Statuses to view here',
                          style: DynamicColorTheme.of(context)
                              .data
                              .textTheme
                              .subtitle2))
                  : ListBody(
                      children: statuses
                          .map(
                              (status) => StatusExpansionTile(status: status))
                          .toList(),
                    )
            ],
          );
  }
}
