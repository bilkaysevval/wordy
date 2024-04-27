import 'package:flutter/material.dart';
import 'package:wordy/features/project_utilities/colors_utility.dart';
import 'package:wordy/project_pages/create_list_page.dart';
import 'package:wordy/project_pages/main_page.dart';

import 'my_lists_page.dart';

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    MyListsPage(),
    MainPage(),
    CreateListPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.my_library_books,
            ),
            icon: Icon(
              Icons.my_library_books_outlined,
            ),
            label: 'Lists',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.lightbulb,
            ),
            icon: Icon(
              Icons.lightbulb_outline,
            ),
            label: 'Learn',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.account_box,
            ),
            icon: Icon(
              Icons.account_box_outlined,
            ),
            label: 'You',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showUnselectedLabels: false,
        elevation: 50,
        iconSize: 25, //   CONSTANT VALUE.  SAVE ITTT INTO CLASSSSSSSS
        selectedItemColor: ColorsUtility.rhino,
        unselectedItemColor: ColorsUtility.rhino,
      ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// class NavigationExample extends StatefulWidget {
//   const NavigationExample({super.key});
//
//   @override
//   State<NavigationExample> createState() => _NavigationExampleState();
// }
//
// class _NavigationExampleState extends State<NavigationExample> {
//   int currentPageIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: NavigationBar(
//         labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
//         selectedIndex: currentPageIndex,
//         onDestinationSelected: (int index) {
//           setState(() {
//             currentPageIndex = index;
//           });
//         },
//         destinations: const <Widget>[
//           NavigationDestination(
//             selectedIcon: Icon(Icons.my_library_books),
//             icon: Icon(Icons.my_library_books_outlined),
//             label: 'Lists',
//           ),
//           NavigationDestination(
//             selectedIcon: Icon(Icons.lightbulb),
//             icon: Icon(Icons.lightbulb_outline),
//             label: 'Learn',
//           ),
//           NavigationDestination(
//             selectedIcon: Icon(Icons.account_box),
//             icon: Icon(Icons.account_box_outlined),
//             label: 'You',
//           ),
//         ],
//       ),
//     );
//   }
// }
