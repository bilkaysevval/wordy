import 'package:flutter/material.dart';

import '../features/project_utilities/colors_utility.dart';
import '../features/project_utilities/sizes_utility.dart';
import '../features/project_utilities/text_utility.dart';

class DrawerPageView extends StatefulWidget {
  const DrawerPageView({super.key});

  @override
  State<DrawerPageView> createState() => _DrawerPageViewState();
}

class _DrawerPageViewState extends State<DrawerPageView> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorsUtility.matisse,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset('assets/logo/wordy_logo.png'),
            const TextUtility(
                txt: 'WORDY',
                color: ColorsUtility.sorbus,
                size: SizesUtility.mainSize),
            const TextUtility(
                txt: 'Your funny vocabulary app :)',
                color: ColorsUtility.daintree,
                size: SizesUtility.defaultSize),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextUtility(
                    txt: 'for my github account',
                    color: ColorsUtility.daintree,
                    size: SizesUtility.defaultSize),
                TextButton(
                    onPressed:
                        () {}, // for using this click link we have to use url_launcher package
                    child: const TextUtility(
                      txt: 'click here!',
                      color: ColorsUtility.trinidad,
                      size: SizesUtility.defaultSize,
                    )),
              ],
            ),
            const TextUtility(
                txt:
                    'Version', // for getting version of app we have to use package_info_plus package
                color: ColorsUtility.sorbus,
                size: SizesUtility.defaultSize),
          ],
        ),
      ),
    );
  }
}
