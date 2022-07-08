import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import './states.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(UserScreenInitialState());

  static UserCubit get(context) => BlocProvider.of(context);

//........................initialize database.................................
  Future<void> initialDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'usersDatabase.db');

    debugPrint('Database Initialized');

    openUsersDatabase(path);

    emit(UsersDatabaseInitialized());
  }

//..............................creating database..............................
  late Database database;

  Future<void> openUsersDatabase(String path) async {
    await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE usersDatabase (id INTEGER PRIMARY KEY, name TEXT)');
      debugPrint('database created');
    }, onOpen: (Database db) async {
      debugPrint('database opened');
      database = db;
      fetchData();
    });
  }

//............................insert into database...................................
  final textController = TextEditingController();

  Future<void> insertIntoDatabase() async {
    if (wantedUser.isNotEmpty) {
      updateRecord();
      return;
    }
    // Insert some records in a transaction
    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO usersDatabase(name) VALUES("${textController.text}")');
      textController.clear();
      debugPrint('insert data into database');
    });
    fetchData();
    emit(InsertDataToUserDatabaseState());
  }

  //.............................Fetch data from database............................
  List<Map> _usersData = [];

  List<Map> get usersData => [..._usersData];

  Future<void> fetchData() async {
    // Get the records
    final response = await database.rawQuery('SELECT * FROM usersDatabase');

    _usersData = response;

    debugPrint('fetchedData');
    emit(FetchDataState());
  }

  //.....................Update record.........................................

  Map wantedUser = {};

  void selectUser(String name, int id) {
    textController.text = name;
    wantedUser = {
      'name': name,
      'id': id,
    };

    emit(SelectUserState());
  }

  Future<void> updateRecord() async {
    await database.rawUpdate(
        'UPDATE usersDatabase SET name = ? WHERE id = ${wantedUser['id']}',
        [textController.text]);
    debugPrint('User Data updated');
    textController.clear();
    wantedUser = {};

    fetchData();
  }

  //....................Delete some record..............................

  Future<void> deleteRecord() async {
    await database.rawDelete(
        'DELETE FROM usersDatabase WHERE id = ?', ['${wantedUser['id']}']);
    debugPrint('Record deleted');
    textController.clear();
    fetchData();
  }
}
