import 'package:flutter/material.dart';
import 'package:wordy/features/customs/custom_toast_message.dart';

import '../database/db/db.dart';
import '../database/models/my_lists_model.dart';
import '../database/models/words_model.dart';
import '../features/customs/custom_app_bar.dart';
import '../features/project_utilities/colors_utility.dart';
import '../features/project_utilities/sizes_utility.dart';
import '../features/project_utilities/text_utility.dart';

class CreateListPage extends StatefulWidget {
  const CreateListPage({super.key});

  @override
  State<CreateListPage> createState() => _CreateListPageState();
}

class _CreateListPageState extends State<CreateListPage> {
  final listNameController = TextEditingController();
  List<Row> rowsList = [];
  List<TextEditingController> controllerList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i = 0; i < 4; i++) {
      controllerList.add(TextEditingController());
    }
    for (int i = 0; i < 2; i++) {
      rowsList.add(Row(
        children: [
          Expanded(
              child: _CustomTextField(
            controller: controllerList[2 * i],
          )),
          Expanded(
              child: _CustomTextField(
            controller: controllerList[2 * i + 1],
          )),
        ],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'List 1',
          context: context,
          actionType: ActionType.logo,
        ),
        body: SafeArea(
          child: Container(
            color: ColorsUtility.daintree,
            child: Column(
              children: [
                _CustomTextField(
                  controller: listNameController,
                  icon: const Icon(
                    Icons.format_list_bulleted_outlined,
                    color: ColorsUtility.daintree,
                  ),
                  hintText: 'List Name',
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextUtility(
                        txt: 'English',
                        color: ColorsUtility.puertoRico,
                        size: SizesUtility.defaultSize),
                    TextUtility(
                        txt: 'Turkish',
                        color: ColorsUtility.puertoRico,
                        size: SizesUtility.defaultSize),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: rowsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return rowsList[index];
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _CustomButton(
                      icon: Icons.delete_outline,
                      action: deleteRow,
                    ),
                    _CustomButton(icon: Icons.add, action: addRow),
                    _CustomButton(
                      icon: Icons.save_outlined,
                      action: saveList,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deleteRow() {
    if (rowsList.length > 2) {
      // rowsList.length != 2
      controllerList.removeAt(controllerList.length - 1);
      controllerList.removeAt(controllerList.length - 1);
      rowsList.removeAt(rowsList.length - 1);
      setState(() => rowsList);
    } else {
      customToastMsg('must be at least 2 pair in list');
    }
  }

  void saveList() async {
    int counter = 0;
    bool notEmptyFair = true;

    for (int i = 0; i < controllerList.length / 2; i++) {
      String eng = controllerList[2 * i].text;
      String tr = controllerList[2 * i + 1].text;
      if (eng.trim().isNotEmpty && tr.trim().isNotEmpty) {
        counter++;
      } else {
        notEmptyFair = false;
      }
    }

    if (counter < 2) {
      customToastMsg('min 2 pair must be filled');
    } else {
      if (!notEmptyFair) {
        customToastMsg('fill or delete empty fields');
      } else {
        if (listNameController.text.trim().isEmpty) {
          customToastMsg('fill the list name');
        } else {
          MyLists addedList =
              await DB.instance.addList(MyLists(name: listNameController.text));
          for (int i = 0; i < controllerList.length / 2; i++) {
            String eng = controllerList[2 * i].text;
            String tr = controllerList[2 * i + 1].text;

            Word word = await DB.instance.addWord(Word(
                list_id: addedList.id,
                word_eng: eng,
                word_tr: tr,
                status: false));
          }
          customToastMsg("list created");
          // Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => const MyListsPage(),
          //     ));
        }
      }
    }

    for (int i = 0; i < controllerList.length / 2; i++) {
      String eng = controllerList[2 * i].text;
      String tr = controllerList[2 * i + 1].text;
      if (eng.isNotEmpty || tr.isNotEmpty) {
        debugPrint("$eng $tr");
      } else {
        debugPrint("bos");
      }
    }
  }

  void addRow() {
    controllerList.add(TextEditingController());
    controllerList.add(TextEditingController());
    rowsList.add(Row(
      children: [
        Expanded(
            child: _CustomTextField(
                controller: controllerList[controllerList.length - 2])),
        Expanded(
            child: _CustomTextField(
                controller: controllerList[controllerList.length - 1])),
      ],
    ));
    setState(() => rowsList);
  }
}

class _CustomTextField extends StatelessWidget {
  const _CustomTextField(
      {super.key, required this.controller, this.icon, this.hintText});
  final TextEditingController controller;
  final Icon? icon;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: ColorsUtility.puertoRico,
        borderRadius: BorderRadius.circular(5),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: TextField(
          textAlign: TextAlign.left,
          maxLines: 1,
          controller: controller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            icon: icon,
            border: InputBorder.none,
            hintText: hintText,
            isDense: true,
          ),
        ),
      ),
    );
  }
}

class _CustomButton extends StatefulWidget {
  final IconData icon;
  final Function action;
  const _CustomButton({
    super.key,
    required this.icon,
    required this.action,
  });
  @override
  State<_CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<_CustomButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      backgroundColor: ColorsUtility.trinidad,
      onPressed: () {
        widget.action();
      },
      child: Icon(
        widget.icon,
        color: ColorsUtility.daintree,
      ),
    );
  }
}

class _CustomAlertDialog extends StatelessWidget {
  const _CustomAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorsUtility.sorbus,
      title: const TextUtility(
        color: ColorsUtility.daintree,
        size: SizesUtility.defaultSize,
        txt: 'There must be at least two words in list!',
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const TextUtility(
                txt: 'Close',
                color: ColorsUtility.daintree,
                size: SizesUtility.defaultSize)),
      ],
    );
  }
}
