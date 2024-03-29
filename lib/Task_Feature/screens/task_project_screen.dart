import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';

import '../../../Task_Feature/Task_Feature.dart';

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
            tabs: [
              Tab(
                icon: Icon(Icons.topic_rounded),
                text: 'Projects',
              ),
              Tab(
                icon: Icon(Icons.rule_rounded),
                text: 'Tasks',
              )
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