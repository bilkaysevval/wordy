import 'package:flutter/material.dart';

class CustomPopupMenu extends StatefulWidget {
  const CustomPopupMenu({super.key});

  @override
  State<CustomPopupMenu> createState() => _CustomPopupMenuState();
}

class _CustomPopupMenuState extends State<CustomPopupMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Menu>(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
        const PopupMenuItem<Menu>(
          value: Menu.addNewWords,
          child: ListTile(
            leading: Icon(Icons.add_circle_outlined),
            title: Text('Add Words'),
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem<Menu>(
          value: Menu.deleteWords,
          child: ListTile(
            leading: Icon(Icons.remove_circle_outline),
            title: Text('Delete Words'),
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem<Menu>(
          value: Menu.cancel,
          child: ListTile(
            leading: Icon(Icons.cancel_outlined),
            title: Text('Cancel'),
          ),
        ),
      ],
    );
  }
}

enum Menu { addNewWords, deleteWords, cancel }
