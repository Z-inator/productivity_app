import 'package:flutter/material.dart';
import 'home_screen.dart';


class BaseFramework extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log'),
      ),
      body: HomeScreen(),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(),
          child: Container(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: IconButton(
                    icon: Icon(Icons.home_rounded),
                    iconSize: 30.0,
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: Icon(Icons.timer_rounded),
                    iconSize: 30.0,
                    onPressed: () {},
                  ),
                ),
                Spacer(),
                Expanded(
                  child: IconButton(
                    icon: Icon(Icons.playlist_add_rounded),
                    iconSize: 30.0,
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: Icon(Icons.gavel_rounded),
                    iconSize: 30.0,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          )),
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
    );
  }
}

