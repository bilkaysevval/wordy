import 'package:flutter/material.dart';

import '../project_utilities/colors_utility.dart';
import '../project_utilities/sizes_utility.dart';
import '../project_utilities/text_utility.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, required this.context});
  final String title;
  final BuildContext context;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AppBar(
          iconTheme: const IconThemeData(color: ColorsUtility.trinidad),
          backgroundColor: ColorsUtility.daintree,
          elevation: 10,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextUtility(
                  txt: title,
                  color: ColorsUtility.trinidad,
                  size: SizesUtility.defaultSize),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * 0.2,
                child: Image.asset('assets/logo/wordy_logo.png'),
              ),
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
