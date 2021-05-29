import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_list_tab.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_list_tab.dart';

class TaskProjectScreen extends StatefulWidget {
  @override
  _TaskProjectScreenState createState() => _TaskProjectScreenState();
}

class _TaskProjectScreenState extends State<TaskProjectScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Column(children: [
          TabBar(
              unselectedLabelColor:
                  DynamicTheme.of(context).theme.unselectedWidgetColor,
              labelColor:
                  DynamicTheme.of(context).theme.textTheme.subtitle1.color,
              indicatorColor: DynamicTheme.of(context).theme.accentColor,
              labelPadding: EdgeInsets.fromLTRB(5, 20, 5, 10),
              tabs: [Text('Projects'), Text('Tasks')]),
          Expanded(
            child: TabBarView(children: [ProjectScreen(), TaskScreen()]),
          ),
        ]));
  }
}
