import 'package:flutter/material.dart';

import '../features/customs/custom_app_bar.dart';
import '../features/project_utilities/colors_utility.dart';
import 'create_list_page.dart';

class MyListsPage extends StatefulWidget {
  const MyListsPage({super.key});

  @override
  State<MyListsPage> createState() => _MyListsPageState();
}

class _MyListsPageState extends State<MyListsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: 'My Lists',
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
