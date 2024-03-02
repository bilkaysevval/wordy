import 'package:flutter/material.dart';

import '../project_utilities/colors_utility.dart';
import '../project_utilities/sizes_utility.dart';
import '../project_utilities/text_utility.dart';

class CreateListPage extends StatefulWidget {
  const CreateListPage({super.key});

  @override
  State<CreateListPage> createState() => _CreateListPageState();
}

class _CreateListPageState extends State<CreateListPage> {
  final listNameController = TextEditingController();
  List<Row> rowsList = [];
  List<TextEditingController> controllerList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i = 0; i < 4; i++) {
      controllerList.add(TextEditingController());
    }
    for (int i = 0; i < 2; i++) {
      rowsList.add(Row(
        children: [
          Expanded(
              child: _WordTextField(
            controller: controllerList[2 * i],
          )),
          Expanded(
              child: _WordTextField(
            controller: controllerList[2 * i + 1],
          )),
        ],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsUtility.daintree,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextUtility(
                  txt: 'List 1',
                  color: ColorsUtility.trinidad,
                  size: SizesUtility.titleSize),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * 0.2,
                child: Image.asset('assets/logo/wordy_logo.png'),
              ),
            ],
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
              color: ColorsUtility.trinidad, size: SizesUtility.iconSize),
        ),
        body: Container(
          color: ColorsUtility.daintree,
          child: Column(
            children: [
              _WordTextField(
                controller: listNameController,
                icon: const Icon(
                  Icons.format_list_bulleted_outlined,
                  color: ColorsUtility.daintree,
                ),
                hintText: 'List Name',
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextUtility(
                      txt: 'Turkish',
                      color: ColorsUtility.puertoRico,
                      size: SizesUtility.defaultSize),
                  TextUtility(
                      txt: 'English',
                      color: ColorsUtility.puertoRico,
                      size: SizesUtility.defaultSize),
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: rowsList,
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _CustomButton(icon: Icons.delete_outline),
                  _CustomButton(icon: Icons.add),
                  _CustomButton(icon: Icons.save_outlined),
                ],
              ),
              // const Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WordTextField extends StatelessWidget {
  const _WordTextField(
      {super.key, required this.controller, this.icon, this.hintText});
  final TextEditingController controller;
  final Icon? icon;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: ColorsUtility.puertoRico,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        textAlign: TextAlign.left,
        maxLines: 1,
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          icon: icon,
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }
}

class _CustomButton extends StatelessWidget {
  const _CustomButton({super.key, required this.icon});
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      backgroundColor: ColorsUtility.trinidad,
      child: Icon(
        icon,
        color: ColorsUtility.daintree,
      ),
      onPressed: () {},
    );
  }
}
