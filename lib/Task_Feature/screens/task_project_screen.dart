import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/screens/project_screen.dart';
import 'package:productivity_app/Task_Feature/screens/task_screen.dart';
import 'package:provider/provider.dart';

// TODO: look at using an Animated Switcher instead of Provider
class TaskProjectScreen extends StatelessWidget {
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