import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'dart:async';

import 'model/task.dart';

class DataService {
  static final DataService _instance = DataService._internal();
  factory DataService() => _instance;
  Future<Database> database;
  List<Task> taskList;

  static Database _database;

  DataService._internal() {
    taskList = [];
    database = main();
  }

  void addTask(Task task) {
    taskList.add(task);
  }

  void removeTask(Task task) {
    taskList.removeWhere((t) => t.getTaskName == task.getTaskName);
  }




  



  Future<Database> main() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'tasks_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE tasks(id INTEGER PRIMARY KEY, taskName TEXT, dueDate DATE, priority TEXT)",
        );
      },
      version: 1,
    );
    return database;
  }

  Future<void> insertTask(Task task) async {
    final Database db = await database;
    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


}
