import 'package:flutter/material.dart';
import 'package:wordy/features/drawer.dart';
import 'package:wordy/project_utilities/colors_utility.dart';
import 'package:wordy/project_utilities/sizes_utility.dart';
import 'package:wordy/project_utilities/text_utility.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  Languages _chooseLanguage = Languages.eng;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsUtility.daintree,
        elevation: 0,
        title: const TextUtility(txt: 'wordy', color: ColorsUtility.trinidad, size: SizesUtility.titleSize),
        centerTitle: true,
        iconTheme: const IconThemeData(color: ColorsUtility.trinidad, size: SizesUtility.iconSize),
      ),
      drawer: const DrawerPageView(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Padding(
            //   padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 4),
            //   child: listTileWithRadioButton(
            //       gVal: _chooseLanguage,
            //       val: Languages.eng,
            //       txt: 'English',
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 4),
            //   child: listTileWithRadioButton(
            //     gVal: _chooseLanguage,
            //     val: Languages.tr,
            //     txt: 'Turkish',),
            // ),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //       backgroundColor: ColorsUtility.ghostWhite,
            //       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25)))),
            //   onPressed: () {},
            //   child: Padding(
            //     padding: const EdgeInsets.only(top:20, bottom: 20, right: 40, left: 40),
            //     child: Text('My Lists', style: Theme.of(context).textTheme.headlineMedium),
            // ),),
            Center(child: mainPageCard(context)),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 1.5,
              margin: const EdgeInsets.only(bottom: 20),
              height: MediaQuery.of(context).size.height / 7,
              decoration: const BoxDecoration(
                color: ColorsUtility.puertoRico,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: const TextUtility(txt: 'My Cards', size: SizesUtility.titleSize, color: ColorsUtility.daintree),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.height / 7,
              decoration: const BoxDecoration(
                color: ColorsUtility.sorbus,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: const TextUtility(txt: 'Try Me!', size: SizesUtility.titleSize, color: ColorsUtility.daintree),
            ),
          ],
        ),
      ),
    );
  }

  Container mainPageCard(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 20),
      width: MediaQuery.of(context).size.width / 1.5,
      height: MediaQuery.of(context).size.height / 7,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorsUtility.sorbus,
              ColorsUtility.trinidad,
              ColorsUtility.sorbus,
            ]
        ),
      ),
      child: const TextUtility(txt: 'My Lists', size: SizesUtility.titleSize, color: ColorsUtility.daintree)
    );
  }



  ListTile listTileWithRadioButton({
    required Languages val,
    required Languages gVal,
    required String txt
    }) {
    return ListTile(
            title: TextUtility(txt: txt, color: ColorsUtility.daintree, size: SizesUtility.defaultSize),
            leading: Radio<Languages>(
                activeColor: ColorsUtility.puertoRico,
                value: val,
                groupValue: gVal,
                onChanged: (Languages? value) {
                  setState(() {
                    _chooseLanguage = value!;
                  });
                }),
          );
  }
}

enum Languages {eng, tr}





// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: PreferredSize(
//       preferredSize: SizesUtility.appBarSize,
//       child: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: const TextUtility(txt: 'wordy', color: ColorsUtility.smokyTopaz, size: SizesUtility.titleSize),
//         leading: const Icon(Icons.line_weight_outlined, color: ColorsUtility.policeBlue, size: SizesUtility.iconSize),
//         centerTitle: true,
//         // title: Row(
//         //   mainAxisAlignment: MainAxisAlignment.center,
//         //   children: [
//         // SizedBox(
//         //     width: MediaQuery.of(context).size.width * 0.05,
//         //     child: const Icon(
//         //       Icons.line_weight_outlined,
//         //       color: ColorsUtility.policeBlue,
//         //       size: SizesUtility.iconSize,
//         //     )),
//         // SizedBox(
//         //     width: MediaQuery.of(context).size.width * 0.85,
//         //     child: const Center(
//         //         child: TextUtility(
//         //             txt: 'wordy',
//         //             color: ColorsUtility.smokyTopaz,
//         //             size: SizesUtility.titleSize))),
//       ),
//     ),
//     // ),// HEREeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
//     //   body: const SafeArea(
//     //     child: Column( // because widgets are arranged one under the other
//     //       children: [
//     //         ListTile(
//     //           title: TextUtility(txt: 'Turkish', color: ColorsUtility.argent, size: SizesUtility.defaultSize),
//     //           leading: Radio<Languages>(value: Languages.tr, groupValue: _chooseLanguage, onChanged: onChanged),
//     //         )
//     //       ],
//     //     ),
//     //   ),
//   );
// }
// }






