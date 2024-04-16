import 'package:flutter/material.dart';
import 'package:wordy/features/customs/custom_app_bar.dart';
import 'package:wordy/features/project_utilities/colors_utility.dart';
import 'package:wordy/features/project_utilities/sizes_utility.dart';
import 'package:wordy/features/project_utilities/text_utility.dart';

class WordCardsPage extends StatefulWidget {
  const WordCardsPage({super.key});

  @override
  State<WordCardsPage> createState() => _WordCardsPageState();
}

class _WordCardsPageState extends State<WordCardsPage> {
  final WhichOne selectedRadioButton = WhichOne.all;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: 'My Cards', context: context, actionType: ActionType.logo),
      body: SafeArea(
        child: Card(
          margin: const EdgeInsets.all(10),
          color: ColorsUtility.matisse,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                WhichRadioButton(
                  title: "ask the words which i learned",
                  value: WhichOne.learned,
                  selectedOne: selectedRadioButton,
                ),
                WhichRadioButton(
                  title: "ask the words which i unlearned",
                  value: WhichOne.unlearned,
                  selectedOne: selectedRadioButton,
                ),
                WhichRadioButton(
                  title: "ask the all words",
                  value: WhichOne.all,
                  selectedOne: selectedRadioButton,
                )
              ],
            ),
          ),
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
  final WhichOne value, selectedOne;
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
      title: TextUtility(
        txt: title,
        color: ColorsUtility.daintree,
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
