import 'package:flutter/material.dart';
import 'package:productivity_app/screens/tasks/components/project_stream.dart';
import 'package:productivity_app/screens/tasks/components/task_stream.dart';
// import 'package:productivity_app/screens/tasks/test.dart';
import 'package:productivity_app/screens/tasks/components/reusable_task_expansion_tile.dart';


class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.black,
            tabs: [
              Text('Projects'),
              Text('Tasks')
              // Tab(icon: Icon(Icons.fact_check_rounded),),
              // Tab(icon: Icon(Icons.source_rounded),),
              // Tab(icon: Icon(Icons.toc_rounded),),
              // Tab(icon: Icon(Icons.view_list_rounded),),
              // Tab(icon: Icon(Icons.fact_check_rounded),),
              // Tab(icon: Icon(Icons.list_alt_rounded),),
              // Tab(icon: Icon(Icons.topic_rounded),),
            ]
          ),
        body: TabBarView(
          children: [
            NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    automaticallyImplyLeading: false, // Hides the setting drawer icon
                    floating: true,
                    snap: true,
                    stretch: true,
                    expandedHeight: 300.0,
                    backgroundColor: Colors.grey[50],
                    flexibleSpace: FlexibleSpaceBar(
                      stretchModes: <StretchMode>[StretchMode.blurBackground],
                      background: Container(
                          margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                          child: TaskDashboard()),
                    ),
                    forceElevated: innerBoxIsScrolled,
                    onStretchTrigger: () {
                      return;
                    },
                  )
                ];
              },
              body: ProjectStream()
            ),
            NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    automaticallyImplyLeading: false, // Hides the setting drawer icon
                    floating: true,
                    snap: true,
                    stretch: true,
                    expandedHeight: 300.0,
                    backgroundColor: Colors.grey[50],
                    flexibleSpace: FlexibleSpaceBar(
                      stretchModes: <StretchMode>[StretchMode.blurBackground],
                      background: Container(
                          margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                          child: TaskDashboard()),
                    ),
                    forceElevated: innerBoxIsScrolled,
                    onStretchTrigger: () {
                      return;
                    },
                  )
                ];
              },
              body: TaskStream()
            ),
          ]
        ),
      )
    );
  }
}

class TaskDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        ListTile(
          title: Text('Total Number of Tasks:'),
          subtitle: Text('40'),
        ),
        TaskExpansionTile(
          day: 'Today',
          taskCount: 5.toString(),
        ),
        TaskExpansionTile(
          day: 'This Week',
          taskCount: 10.toString(),
        ),
      ],
    );
  }
}
