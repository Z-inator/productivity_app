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
              onPressed: () {
                Navigator.pushNamed(context, '/timepage');
              },
            ),
          ),
          Expanded(
            child: IconButton(
              icon: Icon(Icons.timer_rounded),
              iconSize: 30.0,
              onPressed: () {
                Navigator.pushNamed(context, '/timepage');
              },
            ),
          ),
          Spacer(),
          Expanded(
            child: IconButton(
              icon: Icon(Icons.playlist_add_rounded),
              iconSize: 30.0,
              onPressed: () {
                Navigator.pushNamed(context, '/taskpage');
              },
            ),
          ),
          Expanded(
            child: IconButton(
              icon: Icon(Icons.gavel_rounded),
              iconSize: 30.0,
              onPressed: () {
                Navigator.pushNamed(context, '/goalpage');
              },
            ),
          ),
        ],
      ),
    );
  }
}
