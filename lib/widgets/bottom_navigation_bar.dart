import 'package:flutter/material.dart';

class BottomNavigationBarBase extends StatelessWidget {
  const BottomNavigationBarBase({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: IconButton(
                icon: Icon(Icons.home_rounded),
                iconSize: 30.0,
                autofocus: true,
                focusColor: Colors.red,
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
      );
  }
}