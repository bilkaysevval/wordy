// singleton for creating just one object from a class

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wordy/database/models/my_lists_model.dart';
import 'package:wordy/database/models/words_model.dart';

class DB {
  static final DB instance = DB
      ._init(); // we guaranteed that there will be created a database object and it will be accessible from outside
  static Database?
      _database; // this database parameter is private. so we have to create getter for accessing this object

  DB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('wordy.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final path = join(await getDatabasesPath(), filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE IF NOT EXISTS $myListsTableName(
      ${MyListsTableFields.id} $idType,
      ${MyListsTableFields.name} $textType,
    )
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS $wordsTableName(
      ${WordsTableFields.id} $idType,
      ${WordsTableFields.list_id} $integerType,
      ${WordsTableFields.word_eng} $textType,
      ${WordsTableFields.word_tr} $textType,
      ${WordsTableFields.status} $boolType,
      FOREIGN KEY (${WordsTableFields.list_id}) REFERENCES $myListsTableName (${MyListsTableFields.id})  
    )
    ''');
  }

  Future<MyLists> addList(MyLists myLists) async {
    final db = await instance.database;
    final id = await db.insert(myListsTableName, myLists.toJson());
    return myLists.copy(id: id); // to change the id that new added
  }

  Future<Word> addWord(Word word) async {
    final db = await instance.database;
    final id = await db.insert(wordsTableName, word.toJson());
    return word.copy(id: id);
  }

  Future<List<Word>> getWordsByList(int? listID) async {
    final db = await instance.database;
    final orderBy = '${WordsTableFields.id} ASC';
    final result = await db.query(wordsTableName,
        orderBy: orderBy,
        where:
            '${WordsTableFields.list_id} = ?', // ? means placeholder. allows us to separate the sql code from the data.
        whereArgs: [listID]);
    return result
        .map((json) => Word.fromJson(json))
        .toList(); // words comes in type of json. we mapped this words by converting to list from json
  } // in this block; we can access the words by 'where' clause. return words where WordsTableFields.list_id is equal to listID which we sent by parameter

  Future<List<MyLists>> getAllLists() async {
    final db = await instance.database;
    final orderBy = '${MyListsTableFields.id} ASC';
    final result = await db.query(myListsTableName, orderBy: orderBy);
    return result.map((json) => MyLists.fromJson(json)).toList();
  }

  Future<int> updateWord(Word word) async {
    final db = await instance.database;
    return db.update(wordsTableName,
        word.toJson(), where: '${WordsTableFields.id} = ?', whereArgs: [
      word.id
    ]); // ? means placeholder. allows us to separate the sql code from the data.
  }

  Future<int> updateList(MyLists myList) async {
    final db = await instance.database;
    return db.update(myListsTableName, myList.toJson(),
        where: '${MyListsTableFields.id} = ?', whereArgs: [myList.id]);
  }

  Future<int> deleteWord(int id) async {
    final db = await instance.database;
    return db.delete(wordsTableName,
        where: '${WordsTableFields.id} = ?', whereArgs: [id]);
  }

  Future<int> deleteListAndItsWords(int id) async {
    final db = await instance.database;
    int result = await db.delete(myListsTableName,
        where: '${MyListsTableFields.id} = ?', whereArgs: [id]);
    if (result == 1) {
      // if list is deleted then delete its all words
      db.delete(wordsTableName,
          where: '${WordsTableFields.list_id} = ?', whereArgs: [id]);
    }
    return result;
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
