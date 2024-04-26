import 'package:flutter/material.dart';
import 'package:wordy/project_pages/word_cards_page.dart';

import '../features/customs/custom_app_bar.dart';
import '../features/customs/custom_text_widget.dart';
import '../features/project_utilities/colors_utility.dart';
import '../features/project_utilities/sizes_utility.dart';
import 'drawer.dart';
import 'my_lists_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          context: context, title: 'wordy', actionType: ActionType.logo),
      drawer: const DrawerPageView(),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          color: ColorsUtility.rhino,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyListsPage(),
                    )),
                child: const _CustomCard(
                  text: 'My Lists',
                  color1: ColorsUtility.mandy,
                  color2: ColorsUtility.mandy,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WordCardsPage(),
                    )),
                child: const _CustomCard(
                  text: 'My Cards',
                  color1: ColorsUtility.mandy,
                  color2: ColorsUtility.mandy,
                ),
              ),
              const _CustomCard(
                text: 'Try Me!',
                color1: ColorsUtility.mandy,
                color2: ColorsUtility.mandy,
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
            color: ColorsUtility.rhino));
  }
}
