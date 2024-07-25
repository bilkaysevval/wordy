import 'package:flutter/material.dart';
import 'package:wordy/features/customs/custom_app_bar.dart';
import 'package:wordy/features/customs/custom_text_widget.dart';
import 'package:wordy/features/project_utilities/colors_utility.dart';
import 'package:wordy/features/project_utilities/padding_and_margin_utility.dart';

import '../database/db/db.dart';
import '../features/customs/custom_dropdown_menu.dart';
import '../features/customs/custom_list_item_with_checkbox.dart';

class LearnPage extends StatefulWidget {
  const LearnPage({super.key});

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  List<Map<String, Object?>> _allLists = [];
  final List<String> wordsTypes = ['All', 'Learned', 'Unlearned'];
  final List<String> questionTypes = ['Test', 'Card'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLists();
  }

  void getLists() async {
    _allLists = await DB.instance.getAllLists();
    setState(() {
      _allLists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Improve Your Skills',
        context: context,
        actionType: ActionType.logo,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomDropdownButton(optionsList: wordsTypes),
                CustomDropdownButton(optionsList: questionTypes),
              ],
            ),
            // Expanded(
            //   child: ListView.builder(
            //     itemBuilder: (context, index) {
            //       return CustomListItemWithCheckbox(
            //         route: getLists,
            //         id: _allLists[index]['id'] as int,
            //         index: index,
            //         listName: _allLists[index]['name'].toString(),
            //         sumWords: _allLists[index]['sum_word'] as int,
            //         sumUnlearned: _allLists[index]['sum_unlearned'].toString(),
            //       );
            //     },
            //     itemCount: _allLists.length,
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: PaddingUtility.buttonPadding,
                  child: OutlinedButton(
                      onPressed: () {
                        print(_allLists);
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            width: 1.3, color: ColorsUtility.mandy),
                        padding: PaddingUtility.buttonPadding,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const CustomTextWidget(
                        txt: 'Start',
                        color: ColorsUtility.black,
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
