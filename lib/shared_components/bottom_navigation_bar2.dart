import 'package:flutter/material.dart';

// class BottomNavigationBar2 extends StatefulWidget {
//   @override
//   _BottomNavigationBar2State createState() => _BottomNavigationBar2State();
// }

// class _BottomNavigationBar2State extends State<BottomNavigationBar2> {
//   int _selectedIndex = 0;
  
//   void _onItemTapped (int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
//       child: ClipRRect(
//         borderRadius: BorderRadius.all(Radius.circular(40)),
//         child: BottomNavigationBar(
//           onTap: _onItemTapped,
//           currentIndex: _selectedIndex,
//           selectedItemColor: Colors.blue,
//           elevation: 20,
//           backgroundColor: Colors.red,
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           items: [
//             BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
//             BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Times'),
//             BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Tasks'),
//             BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Goals'),
//           ]
//         ),
//       ),
//     );
//   }
// }


class BottomNavigationBar2 extends StatefulWidget {
  @override
  _BottomNavigationBar2State createState() => _BottomNavigationBar2State();
}

class _BottomNavigationBar2State extends State<BottomNavigationBar2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        child: BottomAppBar(
          color: Colors.blue,
          elevation: 20,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: IconButton(
                    icon: Icon(Icons.home_rounded),
                    color: Colors.red,
                    onPressed: () {
                      Navigator.pushNamed(context, '/homescreen');
                    }),
              ),
              Expanded(
                child: IconButton(
                    icon: Icon(Icons.timer_rounded),
                    onPressed: () {
                      Navigator.pushNamed(context, '/timepage');
                    }),
              ),
              Spacer(),
              Expanded(
                child: IconButton(
                    icon: Icon(Icons.playlist_add_rounded),
                    onPressed: () {
                      Navigator.pushNamed(context, '/projectscreen');
                    }),
              ),
              Expanded(
                child: IconButton(
                    icon: Icon(Icons.gavel_rounded),
                    onPressed: () {
                      Navigator.pushNamed(context, '/goalpage');
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

