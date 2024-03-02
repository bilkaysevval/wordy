import 'package:flutter/material.dart';
import 'package:wordy/features/drawer.dart';
import 'package:wordy/features/my_lists_page.dart';
import 'package:wordy/project_utilities/colors_utility.dart';
import 'package:wordy/project_utilities/sizes_utility.dart';
import 'package:wordy/project_utilities/text_utility.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsUtility.daintree,
        elevation: 0,
        title: const TextUtility(
            txt: 'wordy',
            color: ColorsUtility.trinidad,
            size: SizesUtility.titleSize),
        centerTitle: true,
        iconTheme: const IconThemeData(
            color: ColorsUtility.trinidad, size: SizesUtility.iconSize),
      ),
      drawer: const DrawerPageView(),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          color: ColorsUtility.daintree,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              // Center(child: mainPageCard(context)),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyListsPage(),
                    )),
                child: const _CustomCard(
                  text: 'My Lists',
                  color1: ColorsUtility.trinidad,
                  color2: ColorsUtility.sorbus,
                ),
              ),
              const _CustomCard(
                text: 'My Cards',
                color1: ColorsUtility.trinidad,
                color2: ColorsUtility.sorbus,
              ),
              const _CustomCard(
                text: 'Try Me!',
                color1: ColorsUtility.trinidad,
                color2: ColorsUtility.sorbus,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomCard extends StatelessWidget {
  const _CustomCard(
      {super.key,
      required this.text,
      required this.color1,
      required this.color2});
  final String text;
  final Color color1, color2;
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(bottom: 20),
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 7,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.bottomRight,
              colors: [
                color2,
                color1,
                color2,
              ]),
        ),
        child: TextUtility(
            txt: text,
            size: SizesUtility.titleSize,
            color: ColorsUtility.daintree));
  }
}
