import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log'),
      ),
      body: Center(

      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home),
                iconSize: 30.0,
                padding: EdgeInsets.only(left: 40.0),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.timer),
                iconSize: 30.0,
                padding: EdgeInsets.only(right: 40.0),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.playlist_add),
                iconSize: 30.0,
                padding: EdgeInsets.only(left: 40.0),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.gavel_rounded),
                iconSize: 30.0,
                padding: EdgeInsets.only(right: 40.0),
                onPressed: () {},
              ),
            ],
          ),
        )
      ),
      floatingActionButton: Container(
        height: 65.0,
        width: 65.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {},
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
        )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
