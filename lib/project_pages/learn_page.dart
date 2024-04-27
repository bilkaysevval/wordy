import 'package:flutter/material.dart';
import 'package:wordy/features/customs/custom_app_bar.dart';
import 'package:wordy/features/customs/custom_text_widget.dart';
import 'package:wordy/features/project_utilities/colors_utility.dart';
import 'package:wordy/features/project_utilities/sizes_utility.dart';

class LearnPage extends StatefulWidget {
  const LearnPage({super.key});

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  final List<String> wordsTypes = ['All', 'Learned', 'Unlearned'];
  final List<String> questionTypes = ['Test', 'Card'];
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
          ],
        ),
      ),
    );
  }
}

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton({super.key, required this.optionsList});
  final List<String> optionsList;
  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  late List<String> optionsList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    optionsList = widget.optionsList;
  }

  late String dropdownValue = optionsList.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: ColorsUtility.spindle,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: ColorsUtility.rhino),
        // borderRadius: BorderRadius.circular(10)),
      ),
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_drop_down_outlined),
        // padding: PaddingUtility.buttonPadding,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        // elevation: 16,
        style: const TextStyle(color: ColorsUtility.black),
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
        },
        items: optionsList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: CustomTextWidget(
              txt: value,
              color: ColorsUtility.black,
              size: SizesUtility.fontSize,
            ),
          );
        }).toList(),
      ),
    );
  }
}
