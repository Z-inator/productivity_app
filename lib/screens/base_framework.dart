import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'time_screen.dart';
import 'package:productivity_app/widgets/bottom_navigation_bar.dart';
import 'package:productivity_app/widgets/settings_drawer_widget.dart';

class BaseFramework extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.search_rounded),
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
        child: TimeScreen()
      ),
      bottomNavigationBar: BottomNavigationBarBase(),
      floatingActionButton: Container(
        height: 65.0,
        width: 65.0,
        child: FittedBox(
            child: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.add_rounded,
            color: Colors.white,
          ),
        )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: SettingsDrawer(),
    );
  }
}

