import 'package:flutter/material.dart';

import '../project_utilities/colors_utility.dart';
import '../project_utilities/sizes_utility.dart';
import 'custom_popup_menu.dart';
import 'custom_text_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    required this.context,
    required this.actionType,
  });
  final String title;
  final BuildContext context;
  final ActionType actionType;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AppBar(
          actions: [
            CustomAppBarActionWithTwoParameters(
              actionType: actionType,
            )
          ],
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: ColorsUtility.rhino,
          // elevation: 10,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextWidget(
                  txt: title,
                  color: Colors.white,
                  size: SizesUtility.defaultSize),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height,
              //   width: MediaQuery.of(context).size.width * 0.2,
              //   child: child ?? Image.asset('assets/logo/wordy_logo.png'),
              // ),
            ],
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(MediaQuery.of(context).size.height * 0.065);
}

class CustomAppBarActionWithTwoParameters extends StatelessWidget {
  const CustomAppBarActionWithTwoParameters({
    super.key,
    required this.actionType,
  });
  final ActionType actionType;
  @override
  Widget build(BuildContext context) {
    switch (actionType) {
      case ActionType.logo:
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.2,
          child: Image.asset('assets/logo/wordy_logo.png'),
        );
      case ActionType.popupMenu:
        return const CustomPopupMenu();
    }
  }
}

enum ActionType { logo, popupMenu }
