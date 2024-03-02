import 'package:flutter/material.dart';

import '../project_utilities/colors_utility.dart';
import '../project_utilities/sizes_utility.dart';
import '../project_utilities/text_utility.dart';

class DrawerPageView extends StatefulWidget {
  const DrawerPageView({super.key});

  @override
  State<DrawerPageView> createState() => _DrawerPageViewState();
}

class _DrawerPageViewState extends State<DrawerPageView> {
  @override
  Widget build(BuildContext context) {
    return const Drawer(
      backgroundColor: ColorsUtility.trinidad,
      child: Column(
        children: [
          TextUtility(txt: 'drawer', color: ColorsUtility.puertoRico, size: SizesUtility.mainSize),
        ],
      ),
    );
  }
}
