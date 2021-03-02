import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:productivity_app/screens/home/components/time_tile_list_builder.dart';
import 'package:productivity_app/screens/home/components/home_page_dashboard.dart';
import 'package:productivity_app/shared_components/base_framework.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1200,
      child: Container(
        color: Colors.green,
      ),
    );
    // BaseFramework(
    //   dashboard: HomeDashboard(),
    //   content: TimeTileList(),
    // );
    // Column(
    //   mainAxisSize: MainAxisSize.min,
    //   crossAxisAlignment: CrossAxisAlignment.stretch,
    //   children: <Widget>[
    //     Flexible(
    //       flex: 1,
    //       fit: FlexFit.loose,
    //       child: HomeDashboard()
    //     ),
    //     Flexible(
    //       flex: 1,
    //       fit: FlexFit.loose,
    //       child: Scrollbar(
    //         child: ListView(
    //           children: <Widget>[
    //             TimeTileList(),
    //             TimeTileList(),
    //             TimeTileList(),
    //             TimeTileList(),
    //           ],
    //         ),
    //       )
    //     )
    //   ]
    // );
  }
}
