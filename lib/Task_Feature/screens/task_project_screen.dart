import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/screens/project_screen.dart';
import 'package:productivity_app/Task_Feature/screens/task_screen.dart';
import 'package:provider/provider.dart';

class TaskProjectScreen extends StatefulWidget {
  @override
  _TaskProjectScreenState createState() => _TaskProjectScreenState();
}

class _TaskProjectScreenState extends State<TaskProjectScreen> with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive => true;
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
        TabBar(
          unselectedLabelColor: DynamicColorTheme.of(context).data.unselectedWidgetColor,
          labelColor: DynamicColorTheme.of(context).data.textTheme.subtitle1.color,
          indicatorColor: DynamicColorTheme.of(context).data.accentColor,
          labelPadding: EdgeInsets.fromLTRB(5, 20, 5, 10),
            tabs: [
              Text('Projects'),
              Text('Tasks')
            ]
          ),
        Expanded(
          child: TabBarView(
            children: [
              ProjectScreen(),
              TaskScreen()
            ]
          ),
        ),
        ]
      )
    );
  }
}