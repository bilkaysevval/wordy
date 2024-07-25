import 'package:flutter/material.dart';

import '../project_utilities/colors_utility.dart';
import '../project_utilities/sizes_utility.dart';
import 'custom_text_widget.dart';

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
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
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
