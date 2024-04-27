import 'package:flutter/material.dart';

import '../features/customs/custom_text_widget.dart';
import '../features/project_utilities/colors_utility.dart';
import '../features/project_utilities/sizes_utility.dart';

class DrawerPageView extends StatefulWidget {
  const DrawerPageView({super.key});

  @override
  State<DrawerPageView> createState() => _DrawerPageViewState();
}

class _DrawerPageViewState extends State<DrawerPageView> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorsUtility.spindle,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset('assets/logo/wordy_logo.png'),
            const CustomTextWidget(
                txt: 'WORDY',
                color: ColorsUtility.mandy,
                size: SizesUtility.mainSize),
            const CustomTextWidget(
                txt: 'Your funny vocabulary app :)',
                color: ColorsUtility.rhino,
                size: SizesUtility.defaultSize),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomTextWidget(
                    txt: 'for my github account',
                    color: ColorsUtility.rhino,
                    size: SizesUtility.defaultSize),
                TextButton(
                    onPressed:
                        () {}, // for using this click link we have to use url_launcher package
                    child: const CustomTextWidget(
                      txt: 'click here!',
                      color: ColorsUtility.mandy,
                      size: SizesUtility.defaultSize,
                    )),
              ],
            ),
            const CustomTextWidget(
                txt:
                    'Version', // for getting version of app we have to use package_info_plus package
                color: ColorsUtility.mandy,
                size: SizesUtility.defaultSize),
          ],
        ),
      ),
    );
  }
}
