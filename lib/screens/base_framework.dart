import 'package:flutter/material.dart';
import 'home_screen.dart';

class BaseFramework extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: Icon(Icons.all_out),
                  title: Text('The Enchanted Nightingale'),
                  subtitle:
                      Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: const Text('BUY TICKETS'),
                      onPressed: () {/* ... */},
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      child: const Text('LISTEN'),
                      onPressed: () {/* ... */},
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 150.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Card(
                  child: Column(
                    children: <Widget>[ 
                      Text('Most recent time log'),
                      Text('Associated project'),
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.play_arrow_rounded),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.edit_location_rounded),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.delete_outline_rounded),
                            onPressed: () {},
                          ),
                        ]
                      )
                    ],
                    )
                  ),
              ],
            ),
          ),
        ],
      ),
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
