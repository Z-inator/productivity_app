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
  List<Widget> icons = [
    Icon(Icons.home_rounded),
    Icon(Icons.timer_rounded),
    Icon(Icons.playlist_add_rounded),
    Icon(Icons.gavel_rounded)
  ];
  int selectedPage = 0;

  void setPage(int index) {
    setState(() {
      selectedPage = index;
    });
  }
  
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
                    icon: icons[0],
                    color: selectedPage == 0 ? Colors.red : Colors.white,
                    onPressed: () {
                      setPage(0);
                      Navigator.pushReplacementNamed(context, '/homescreen');
                    }),
              ),
              Expanded(
                child: IconButton(
                    icon: icons[1],
                    color: selectedPage == 1 ? Colors.red : Colors.white,
                    onPressed: () {
                      setPage(0);
                      Navigator.pushReplacementNamed(context, '/timepage');
                    }),
              ),
              Spacer(),
              Expanded(
                child: IconButton(
                    icon: icons[2],
                    color: selectedPage == 2 ? Colors.red : Colors.white,
                    onPressed: () {
                      setPage(2);
                      Navigator.pushReplacementNamed(context, '/projectscreen');
                    }),
              ),
              Expanded(
                child: IconButton(
                    icon: icons[3],
                    color: selectedPage == 3 ? Colors.red : Colors.white,
                    onPressed: () {
                      setPage(3);
                      Navigator.pushReplacementNamed(context, '/functionalityscreen');
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

