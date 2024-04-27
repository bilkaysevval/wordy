import 'package:flutter/material.dart';
import 'package:wordy/features/customs/custom_toast_message.dart';

import '../database/db/db.dart';
import '../database/models/words_model.dart';
import '../features/customs/custom_app_bar.dart';
import '../features/project_utilities/colors_utility.dart';

class WordsPage extends StatefulWidget {
  const WordsPage({super.key, this.listID, this.listName});
  final int? listID;
  final String? listName;
  @override
  State<WordsPage> createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  late final int? listID;
  late final String? listName;
  List<Word> _wordsList = [];
  bool pressController = false;
  List<bool> deleteIndexList = [];

  @override
  void initState() {
    super.initState();
    listID = widget.listID;
    listName = widget.listName;
    getWordsByList();
  }

  void getWordsByList() async {
    _wordsList = await DB.instance.getWordsByList(listID);
    for (int i = 0; i < _wordsList.length; i++) {
      deleteIndexList.add(false);
    }
    setState(() {
      _wordsList;
    });
  }

  void deleteWords() async {
    List<int> removeIndexList = [];
    for (int i = 0; i < _wordsList.length; i++) {
      if (deleteIndexList[i]) removeIndexList.add(i);
    }
    for (int i = removeIndexList.length - 1; i >= 0; i--) {
      DB.instance.deleteWord(
          _wordsList[removeIndexList[i]].id!); // this part is different
      _wordsList.removeAt(removeIndexList[i]);
      deleteIndexList.removeAt(removeIndexList[i]);
    }
    for (int i = 0; i < deleteIndexList.length; i++) {
      deleteIndexList[i] = false;
    }
    setState(() {
      _wordsList;
      deleteIndexList;
      pressController = false;
      customToastMsg("selected words have been deleted");
    });
  } // same as deleteLists() method in my lists page

  void updatePressController(bool update) {
    setState(() {
      pressController = update;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          context: context, title: listName!, actionType: ActionType.popupMenu),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return _CustomWordItem(
                    wordID: _wordsList[index].id!,
                    index: index,
                    wordENG: _wordsList[index].word_eng!,
                    wordTR: _wordsList[index].word_tr!,
                    status: _wordsList[index].status!,
                    wordsList: _wordsList,
                    pressController: pressController,
                    deleteIndexList: deleteIndexList,
                    updatePressController: updatePressController,
                  );
                },
                itemCount: _wordsList.length,
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
                        setState(() {
                          deleteWords();
                        });
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
                      onPressed: () {
                        setState(() {
                          updatePressController(!pressController);
                          pressController = false;
                        });
                      },
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

class _CustomWordItem extends StatefulWidget {
  const _CustomWordItem(
      {super.key,
      required this.wordID,
      required this.index,
      required this.wordTR,
      required this.wordENG,
      required this.status,
      required this.wordsList,
      required this.pressController,
      required this.deleteIndexList,
      required this.updatePressController});
  final int wordID, index;
  final String? wordTR, wordENG;
  final bool? status, pressController;
  final List<Word> wordsList;
  final List<bool> deleteIndexList;
  final Function updatePressController;
  @override
  State<_CustomWordItem> createState() => _CustomWordItemState();
}

class _CustomWordItemState extends State<_CustomWordItem> {
  late int wordID, index;
  late String? wordTR, wordENG;
  late bool? status, pressController;
  late List<Word> wordsList;
  late List<bool> deleteIndexList;
  late Function updatePressController;

  @override
  void initState() {
    super.initState();
    // Move the initialization to initState
    wordID = widget.wordID;
    index = widget.index;
    wordTR = widget.wordTR;
    wordENG = widget.wordENG;
    status = widget.status;
    pressController = widget.pressController;
    wordsList = widget.wordsList;
    deleteIndexList = widget.deleteIndexList;
    updatePressController = widget.updatePressController;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorsUtility.spindle,
      child: ListTile(
        onLongPress: () {
          setState(() {
            updatePressController(!pressController!);
            pressController =
                !pressController!; // shows the checkbox on trailing
          });
        },
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        leading: !pressController!
            ? Checkbox(
                checkColor: ColorsUtility.mandy,
                activeColor: ColorsUtility.spindle,
                hoverColor: ColorsUtility.rhino,
                value: status,
                onChanged: (bool? value) {
                  setState(() {
                    status = value;
                    wordsList[index] = wordsList[index].copy(status: value);
                    if (value == true) {
                      customToastMsg("marked as learned");
                      DB.instance.markAs(true, wordsList[index].id as int);
                    } else {
                      customToastMsg("marked as unlearned");
                      DB.instance.markAs(false, wordsList[index].id as int);
                    }
                  });
                },
              )
            : null,
        title: Text(wordENG!),
        subtitle: Text(wordTR!),
        trailing: pressController!
            ? Checkbox(
                checkColor: ColorsUtility.mandy,
                activeColor: ColorsUtility.spindle,
                hoverColor: ColorsUtility.rhino,
                value: deleteIndexList[index],
                onChanged: (bool? value) {
                  setState(() {
                    deleteIndexList[index] = value!;
                    bool checkboxController = false;
                    for (var element in deleteIndexList) {
                      if (element) checkboxController = true;
                    }
                    if (!checkboxController) {
                      updatePressController(!pressController!);
                      pressController = false;
                    }
                  });
                },
              )
            : null,
      ),
    );
  }
}
