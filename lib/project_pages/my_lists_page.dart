import 'package:flutter/material.dart';

import '../database/db/db.dart';
import '../features/customs/custom_app_bar.dart';
import '../features/project_utilities/colors_utility.dart';
import 'create_list_page.dart';

class MyListsPage extends StatefulWidget {
  const MyListsPage({super.key});

  @override
  State<MyListsPage> createState() => _MyListsPageState();
}

class _MyListsPageState extends State<MyListsPage> {
  List<Map<String, Object?>> _lists = [];
  bool pressController = false;
  List<bool> deleteIndexList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLists();
  }

  void getLists() async {
    _lists = await DB.instance.getAllLists();
    for (int i = 0; i < _lists.length; i++) {
      deleteIndexList.add(false);
    }
    setState(() {
      _lists;
    });
  }

  void updatePressController(bool update) {
    setState(() {
      pressController = update;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: 'My Lists',
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorsUtility.trinidad,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateListPage(),
              ));
        },
        child: const Icon(Icons.add, color: ColorsUtility.daintree),
      ),
      body: SafeArea(
        child: Container(
            color: ColorsUtility.daintree,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return _CustomListTile(
                  id: _lists[index]['id'] as int,
                  index: index,
                  listName: _lists[index]['name'].toString(),
                  sumWords: _lists[index]['sum_word'] as int,
                  sumUnlearned: _lists[index]['sum_unlearned'].toString(),
                  pressController: pressController,
                  updatePressController: updatePressController,
                  deleteIndexList: deleteIndexList,
                );
              },
              itemCount: _lists.length,
            )),
      ),
    );
  }
}

class _CustomListTile extends StatefulWidget {
  const _CustomListTile({
    super.key,
    required this.id,
    required this.listName,
    required this.sumWords,
    required this.sumUnlearned,
    required this.updatePressController,
    required this.pressController,
    required this.index,
    required this.deleteIndexList,
  });
  final int? id;
  final String? listName;
  final int? sumWords;
  final String? sumUnlearned;
  final bool pressController;
  final Function updatePressController;
  final int index;
  final List<bool> deleteIndexList;
  @override
  State<_CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<_CustomListTile> {
  @override
  Widget build(BuildContext context) {
    int sumUnlearned = 0;
    if (widget.sumUnlearned != null) {
      sumUnlearned = int.parse(widget.sumUnlearned!);
    }
    return Card(
      color: ColorsUtility.puertoRico,
      child: ListTile(
        onLongPress: () {
          setState(() {
            widget.updatePressController(!widget.pressController);
            widget.deleteIndexList[widget.index] = true;
          });
        },
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        title: Text(widget.listName!),
        subtitle: Text(
          'Words: ${widget.sumWords} \n'
          'Learned: ${(widget.sumWords! - sumUnlearned)} \n'
          'Unlearned: ${widget.sumUnlearned}',
        ),
        trailing: widget.pressController
            ? Checkbox(
                checkColor: ColorsUtility.sorbus,
                activeColor: ColorsUtility.matisse,
                hoverColor: ColorsUtility.daintree,
                value: true,
                onChanged: (bool? value) {},
              )
            : null,
      ),
    );
  }
}
