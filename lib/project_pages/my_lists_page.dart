import 'package:flutter/material.dart';
import 'package:wordy/features/customs/custom_toast_message.dart';
import 'package:wordy/project_pages/words_page.dart';

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
  List<Map<String, Object?>> _allLists = [];
  bool pressController = false;
  List<bool> deleteIndexList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLists();
  }

  void getLists() async {
    _allLists = await DB.instance.getAllLists();
    for (int i = 0; i < _allLists.length; i++) {
      deleteIndexList.add(false);
    }
    setState(() {
      _allLists;
    });
  }

  void deleteLists() async {
    List<int> removeIndexList = [];
    // add the indexes of lists into removeIndexList, which will be deleted
    for (int i = 0; i < _allLists.length; i++) {
      if (deleteIndexList[i]) removeIndexList.add(i);
    }
    // delete lists from database by using their id
    // start from the end because if we start from the beginning then indexes will be changed
    for (int i = removeIndexList.length - 1; i >= 0; i--) {
      DB.instance
          .deleteListAndItsWords(_allLists[removeIndexList[i]]['id'] as int);
      _allLists.removeAt(removeIndexList[i]);
      deleteIndexList.removeAt(removeIndexList[i]);
    }
    for (int i = 0; i < deleteIndexList.length; i++) {
      deleteIndexList[i] = false;
    }
    setState(() {
      _allLists;
      deleteIndexList;
      pressController = false;
      customToastMsg("selected lists have been deleted");
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
          context: context, title: 'My Lists', actionType: ActionType.logo),
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
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return _CustomListItem(
                        route: getLists,
                        id: _allLists[index]['id'] as int,
                        index: index,
                        listName: _allLists[index]['name'].toString(),
                        sumWords: _allLists[index]['sum_word'] as int,
                        sumUnlearned:
                            _allLists[index]['sum_unlearned'].toString(),
                        pressController: pressController,
                        updatePressController: updatePressController,
                        deleteIndexList: deleteIndexList,
                      );
                    },
                    itemCount: _allLists.length,
                  ),
                ),
                if (pressController)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: ColorsUtility.trinidad,
                            elevation: 10,
                            foregroundColor: ColorsUtility.daintree,
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                          ),
                          onPressed: () {
                            deleteLists();
                          },
                          child: const Text('Delete'),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: ColorsUtility.trinidad,
                            elevation: 10,
                            foregroundColor: ColorsUtility.daintree,
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                          ),
                          onPressed: () {},
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                  ),
              ],
            )),
      ),
    );
  }
}

class _CustomListItem extends StatefulWidget {
  const _CustomListItem({
    super.key,
    required this.id,
    required this.listName,
    required this.sumWords,
    required this.sumUnlearned,
    required this.updatePressController,
    required this.pressController,
    required this.index,
    required this.deleteIndexList,
    required this.route,
  });
  final int? id;
  final String? listName;
  final int? sumWords;
  final String? sumUnlearned;
  final bool pressController;
  final Function updatePressController;
  final Function route;
  final int index;
  final List<bool> deleteIndexList;
  @override
  State<_CustomListItem> createState() => _CustomListItemState();
}

class _CustomListItemState extends State<_CustomListItem> {
  @override
  Widget build(BuildContext context) {
    int sumUnlearned = 0;
    if (widget.sumUnlearned != null) {
      sumUnlearned = int.parse(widget.sumUnlearned!);
    }
    return Card(
      color: ColorsUtility.puertoRico,
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WordsPage(
                  listID: widget.id,
                  listName: widget.listName,
                ),
              )).then((value) => widget.route);
        },
        onLongPress: () {
          setState(() {
            widget.updatePressController(!widget.pressController);
            // widget.deleteIndexList[widget.index] = true;
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
                value: widget.deleteIndexList[widget.index],
                onChanged: (bool? value) {
                  setState(() {
                    widget.deleteIndexList[widget.index] = value!;
                    // for turning back to the old view when none checkbox is selected
                    bool checkboxController = false;
                    for (var element in widget.deleteIndexList) {
                      if (element) checkboxController = true;
                    }
                    if (!checkboxController) {
                      widget.updatePressController(!widget.pressController);
                    }
                  });
                },
              )
            : null,
      ),
    );
  }
}
