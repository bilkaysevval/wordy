import 'package:flutter/material.dart';

import '../../project_pages/words_page.dart';
import '../project_utilities/colors_utility.dart';

class CustomListItem extends StatefulWidget {
  const CustomListItem({
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
  State<CustomListItem> createState() => _CustomListItemState();
}

class _CustomListItemState extends State<CustomListItem> {
  @override
  Widget build(BuildContext context) {
    int sumUnlearned = 0;
    if (widget.sumUnlearned != null) {
      sumUnlearned = int.parse(widget.sumUnlearned!);
    }
    return Card(
      color: ColorsUtility.spindle,
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
                checkColor: ColorsUtility.mandy,
                activeColor: ColorsUtility.spindle,
                hoverColor: ColorsUtility.rhino,
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
