import 'package:flutter/material.dart';
import 'package:wordy/features/customs/custom_app_bar.dart';
import 'package:wordy/features/customs/custom_toast_message.dart';
import 'package:wordy/features/project_utilities/colors_utility.dart';
import 'package:wordy/features/project_utilities/sizes_utility.dart';

import '../database/db/db.dart';
import '../database/models/words_model.dart';
import '../features/customs/custom_text_widget.dart';

class WordCardsPage extends StatefulWidget {
  const WordCardsPage({super.key});

  @override
  State<WordCardsPage> createState() => _WordCardsPageState();
}

class _WordCardsPageState extends State<WordCardsPage> {
  WhichOne? selectedRadioButton = WhichOne.unlearned;
  List<Map<String, Object?>> _lists = [];
  List<bool> selectedListIndexes =
      []; // for saving the bool value whether the list is selected ( means checked ) or not

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLists();
  }

  void getLists() async {
    _lists = await DB.instance.getAllLists();
    for (int i = 0; i < _lists.length; i++) {
      selectedListIndexes.add(false);
    }
    setState(() {
      _lists;
    });
  }

  void getSelectedWordsOfLists(List<int> selectedListsID) async {
    List<Word> words = [];

    if (selectedRadioButton == WhichOne.learned) {
      words = await DB.instance.getWordsOfListsByStatus(selectedListsID, true);
    } else if (selectedRadioButton == WhichOne.unlearned) {
      words = await DB.instance.getWordsOfListsByStatus(selectedListsID, false);
    } else {
      words = await DB.instance.getWordsOfListsByStatus(selectedListsID, null);
    }
    setState(() {
      words;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: 'My Cards', context: context, actionType: ActionType.logo),
      body: SafeArea(
        child: Card(
          margin: const EdgeInsets.all(10),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                WhichRadioButton(
                  title: "ask the words which i learned",
                  value: WhichOne.learned,
                  selectedOne: selectedRadioButton!,
                ),
                WhichRadioButton(
                  title: "ask the words which i unlearned",
                  value: WhichOne.unlearned,
                  selectedOne: selectedRadioButton!,
                ),
                WhichRadioButton(
                  title: "ask the all words",
                  value: WhichOne.all,
                  selectedOne: selectedRadioButton!,
                ),
                const Divider(),
                const CustomTextWidget(
                    txt: 'lists',
                    color: ColorsUtility.rhino,
                    size: SizesUtility.defaultSize),
                Expanded(
                  child: Scrollbar(
                      child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListsToBeAsked(
                        title: _lists[index]['name'].toString(),
                        selectedListIndexes: selectedListIndexes,
                        index: index,
                      );
                    },
                    itemCount: _lists.length,
                  )),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: TextButton(
                      onPressed: () {
                        List<int> selectedListIndexesToAsk =
                            []; // for saving the selected ( means checked ) list's index numbers
                        for (int i = 0; i < selectedListIndexes.length; i++) {
                          if (selectedListIndexes[i]) {
                            selectedListIndexesToAsk.add(i);
                          }
                        }
                        List<int> selectedListsID =
                            []; // for saving the selected ( means checked ) list's IDs
                        for (int i = 0;
                            i < selectedListIndexesToAsk.length;
                            i++) {
                          selectedListsID.add(
                              _lists[selectedListIndexesToAsk[i]]['id'] as int);
                        }
                        if (selectedListsID.isNotEmpty) {
                          customToastMsg('lists being prepared');
                          getSelectedWordsOfLists(selectedListsID);
                        } else {
                          customToastMsg('please select a list');
                        }
                      },
                      child: const CustomTextWidget(
                        txt: 'Start!',
                        color: ColorsUtility.spindle,
                        size: SizesUtility.defaultSize,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListsToBeAsked extends StatefulWidget {
  const ListsToBeAsked(
      {super.key,
      required this.title,
      required this.selectedListIndexes,
      required this.index});
  final String? title;
  final List<bool>? selectedListIndexes;
  final int? index;
  @override
  State<ListsToBeAsked> createState() => _ListsToBeAskedState();
}

class _ListsToBeAskedState extends State<ListsToBeAsked> {
  late String? title;
  late List<bool>? selectedListIndexes;
  late int? index;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = widget.title;
    selectedListIndexes = widget.selectedListIndexes;
    index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: CustomTextWidget(
        txt: title!,
        color: ColorsUtility.rhino,
        size: SizesUtility.defaultSize,
      ),
      leading: SizedBox(
        height: 30,
        width: 60,
        child: Checkbox(
          value: selectedListIndexes![index!],
          onChanged: (bool? value) {
            setState(() {
              selectedListIndexes![index!] = value!;
            });
          },
        ),
      ),
    );
  }
}

enum WhichOne { learned, unlearned, all }

class WhichRadioButton extends StatefulWidget {
  const WhichRadioButton(
      {super.key,
      required this.title,
      required this.value,
      required this.selectedOne});
  final String title;
  final WhichOne value;
  final WhichOne selectedOne;
  @override
  State<WhichRadioButton> createState() => _WhichRadioButtonState();
}

class _WhichRadioButtonState extends State<WhichRadioButton> {
  late String title;
  late WhichOne value, selectedOne;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = widget.title;
    value = widget.value;
    selectedOne = widget.selectedOne;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: CustomTextWidget(
        txt: widget.title,
        color: ColorsUtility.rhino,
        size: SizesUtility.defaultSize,
      ),
      leading: Radio<WhichOne>(
        value: value,
        groupValue: selectedOne,
        onChanged: (WhichOne? value) {
          setState(() {
            selectedOne = value!;
          });
        },
      ),
    );
  }
}
