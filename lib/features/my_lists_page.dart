import 'package:flutter/material.dart';
import 'package:wordy/features/create_list_page.dart';

import '../project_utilities/colors_utility.dart';
import '../project_utilities/sizes_utility.dart';
import '../project_utilities/text_utility.dart';

class MyListsPage extends StatefulWidget {
  const MyListsPage({super.key});

  @override
  State<MyListsPage> createState() => _MyListsPageState();
}

class _MyListsPageState extends State<MyListsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsUtility.daintree,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TextUtility(
                txt: 'My Lists',
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorsUtility.trinidad,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateListPage(),
              ));
        },
        child: const Icon(Icons.add, color: ColorsUtility.daintree),
      ),
      body: SafeArea(
        child: Container(
          color: ColorsUtility.daintree,
          child: const Column(
            children: [
              _CustomListTile(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomListTile extends StatefulWidget {
  const _CustomListTile({super.key});

  @override
  State<_CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<_CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return const Card(
      color: ColorsUtility.puertoRico,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        title: Text("List's Name"),
        subtitle: Text(
          'Words: 300 \nLearned: 50 \nUnlearned: 250',
        ),
      ),
    );
  }
}

// class _CustomCard extends StatelessWidget {
//   const _CustomCard(
//       {super.key,
//       required this.text,
//       required this.color1,
//       required this.color2});
//   final String text;
//   final Color color1, color2;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         alignment: Alignment.center,
//         margin: const EdgeInsets.only(bottom: 20),
//         width: MediaQuery.of(context).size.width / 1.5,
//         height: MediaQuery.of(context).size.height / 7,
//         decoration: BoxDecoration(
//           borderRadius: const BorderRadius.all(Radius.circular(20)),
//           gradient: LinearGradient(
//               begin: Alignment.centerLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 color2,
//                 color1,
//                 color2,
//               ]),
//         ),
//         child: TextUtility(
//             txt: text,
//             size: SizesUtility.titleSize,
//             color: ColorsUtility.daintree));
//   }
// }
