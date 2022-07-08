import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class AlterDataProvider with ChangeNotifier {
  Future<void> initialDatabase() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'users.db');
    debugPrint('database initialized');
    createDatabase(path);
    notifyListeners();
  }

  //..............................Create data base.............................
  late Database database;

  Future<void> createDatabase(String path) async {
    await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db
          .execute('CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)');
      debugPrint('Table created');
    }, onOpen: (Database db) {
      debugPrint('Database opened');
      database = db;
      fetchData();
    });
    notifyListeners();
  }

  //......................Insert into database......................................
  final textController = TextEditingController();
  Future<void> insertIntoDatabase() async {
    if (wantedUser.isNotEmpty) {
      updateUserData();
      return;
    }
    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO users(name) VALUES("${textController.text}")');
    }).then((value) {
      debugPrint('new data inserted');
      debugPrint(textController.text);
      textController.clear();
      fetchData();
    });

    notifyListeners();
  }

  //...........................fetch Data from database.................................
  List<Map> _dataRecords = [];

  List<Map> get dataRecords {
    return [..._dataRecords];
  }

  Future<void> fetchData() async {
    await database.rawQuery('SELECT * FROM users').then((value) {
      _dataRecords = value;

      debugPrint('Data fetched from database');
    });

    notifyListeners();
  }

  //..........................update an existing product.............................
  Map wantedUser = {};

  Map selectUser(String name, int id) {
    textController.text = name;
    notifyListeners();
    wantedUser = {'id': id, 'name': name};
    return {'id': id, 'name': name};
  }

  Future<void> updateUserData() async {
    database.rawUpdate(
        'UPDATE users SET name = ?  WHERE id = ${wantedUser['id']}',
        [textController.text]).then((_) {
      textController.clear();
      wantedUser = {};
      debugPrint('User Data updated');
      fetchData();
    });
    notifyListeners();
  }

  //.......................delete record...........................................
  Future<void> deleteData() async {
    await database.rawDelete(
        'DELETE FROM users WHERE name = ?', ['${wantedUser['name']}']).then(
      (value) {
        debugPrint('record deleted');
        fetchData();
      },
    );
    notifyListeners();
  }
}
