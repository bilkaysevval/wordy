import 'package:flutter/material.dart';

import '../project_utilities/colors_utility.dart';

class CustomListItemWithCheckbox extends StatefulWidget {
  const CustomListItemWithCheckbox({
    super.key,
    required this.id,
    required this.listName,
    required this.sumWords,
    required this.sumUnlearned,
    required this.index,
  });
  final int? id;
  final String? listName;
  final int? sumWords;
  final String? sumUnlearned;
  final int index;
  @override
  State<CustomListItemWithCheckbox> createState() =>
      _CustomListItemWithCheckboxState();
}

class _CustomListItemWithCheckboxState
    extends State<CustomListItemWithCheckbox> {
  @override
  Widget build(BuildContext context) {
    int sumUnlearned = 0;
    if (widget.sumUnlearned != null) {
      sumUnlearned = int.parse(widget.sumUnlearned!);
    }
    return Card(
      color: ColorsUtility.spindle,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        title: Text(widget.listName!),
        subtitle: Text(
          'Words: ${widget.sumWords} \n'
          'Learned: ${(widget.sumWords! - sumUnlearned)} \n'
          'Unlearned: $sumUnlearned',
        ),
        // trailing: Checkbox(
        //   checkColor: ColorsUtility.mandy,
        //   activeColor: ColorsUtility.spindle,
        //   hoverColor: ColorsUtility.rhino,
        //   value: widget.deleteIndexList[widget.index],
        //   onChanged: (bool? value) {
        //     setState(() {
        //       widget.deleteIndexList[widget.index] = value!;
        //       // for turning back to the old view when none checkbox is selected
        //       bool checkboxController = false;
        //       for (var element in widget.deleteIndexList) {
        //         if (element) checkboxController = true;
        //       }
        //       if (!checkboxController) {
        //         widget.updatePressController(!widget.pressController);
        //       }
        //     });
        //   },
        // ),
      ),
    );
  }
}
