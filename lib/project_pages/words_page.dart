import 'package:flutter/material.dart';
import 'package:wordy/features/customs/custom_toast_message.dart';

import '../database/db/db.dart';
import '../database/models/words_model.dart';
import '../features/customs/custom_app_bar.dart';
import '../features/project_utilities/colors_utility.dart';

class WordsPage extends StatefulWidget {
  const WordsPage({super.key, this.listID, this.listName});
  final int? listID;
  final String? listName;
  @override
  State<WordsPage> createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  late final int? listID;
  late final String? listName;
  List<Word> _wordsList = [];

  @override
  void initState() {
    super.initState();
    listID = widget.listID;
    listName = widget.listName;
    getWordsByList();
  }

  void getWordsByList() async {
    _wordsList = await DB.instance.getWordsByList(listID);
    setState(() {
      _wordsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: listName!,
      ),
      body: SafeArea(
        child: Container(
          color: ColorsUtility.daintree,
          child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                itemBuilder: (context, index) {
                  return _CustomWordItem(
                    wordID: _wordsList[index].id!,
                    index: index,
                    wordENG: _wordsList[index].word_eng,
                    wordTR: _wordsList[index].word_tr,
                    status: _wordsList[index].status,
                    wordsList: _wordsList,
                  );
                },
                itemCount: _wordsList.length,
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomWordItem extends StatefulWidget {
  const _CustomWordItem(
      {super.key,
      required this.wordID,
      required this.index,
      this.wordTR,
      this.wordENG,
      this.status,
      required this.wordsList});
  final int wordID;
  final int index;
  final String? wordTR;
  final String? wordENG;
  final bool? status;
  final List<Word> wordsList;
  @override
  State<_CustomWordItem> createState() => _CustomWordItemState();
}

class _CustomWordItemState extends State<_CustomWordItem> {
  late final int wordID;
  late final int index;
  late final String? wordTR;
  late final String? wordENG;
  late final bool? status;
  late final List<Word> wordsList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wordID = widget.wordID;
    index = widget.index;
    wordTR = widget.wordTR;
    wordENG = widget.wordENG;
    status = widget.status;
    wordsList = widget.wordsList;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorsUtility.puertoRico,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        title: Text(wordENG!),
        subtitle: Text(wordTR!),
        trailing: Checkbox(
          checkColor: ColorsUtility.sorbus,
          activeColor: ColorsUtility.matisse,
          hoverColor: ColorsUtility.daintree,
          value: status,
          onChanged: (bool? value) {
            setState(() {
              wordsList[index] = wordsList[index].copy(status: value);
              if (value == true) {
                customToastMsg("marked as learned");
                DB.instance.markAs(true, wordsList[index].id as int);
              } else {
                customToastMsg("marked as unlearned");
                DB.instance.markAs(false, wordsList[index].id as int);
              }
              wordsList;
            });
          },
        ),
      ),
    );
  }
}
