import 'package:flutter/material.dart';
import 'package:wordy/features/customs/custom_toast_message.dart';

import '../database/db/db.dart';
import '../features/customs/custom_app_bar.dart';
import '../features/customs/custom_list_item.dart';
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
        context: context,
        title: 'Your Lists',
        actionType: ActionType.popupMenu,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorsUtility.mandy,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateListPage(),
              ));
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return CustomListItem(
                    route: getLists,
                    id: _allLists[index]['id'] as int,
                    index: index,
                    listName: _allLists[index]['name'].toString(),
                    sumWords: _allLists[index]['sum_word'] as int,
                    sumUnlearned: _allLists[index]['sum_unlearned'].toString(),
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
                        backgroundColor: ColorsUtility.mandy,
                        elevation: 10,
                        foregroundColor: ColorsUtility.rhino,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                      ),
                      onPressed: () {
                        deleteLists();
                      },
                      child: const Text('Delete'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: ColorsUtility.mandy,
                        elevation: 10,
                        foregroundColor: ColorsUtility.rhino,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                      ),
                      onPressed: () {},
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
