
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path_provider/path_provider.dart';

import 'model/task.dart';

class DatabaseHelper {

  static final _databaseName = "Database.db";
  static final _databaseVersion = 1;
  static final _tableName = 'tasks';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();


  static Database _database;
  Future<Database> get database async {
    if(_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }


  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    
    return await openDatabase(path,
      version: _databaseVersion,
      onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
        await db.execute('''CREATE TABLE tasks(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          taskName TEXT,
          dueDate TEXT,
          priority TEXT
        )''');
      }

  Future<int> insert(Task task) async {
    Database db = await database;
    int id = await db.insert('tasks', task.toMap());
    return id;
  }

  Future<Task> queryTask(int id) async {
    Database db = await database;
    List<Map> maps = await db.query('tasks',
    columns: ['id', 'taskName', 'dueDate', 'priority'],
    where: '$id = ?',
    whereArgs: [id]);

    if (maps.length > 0) {
      return Task.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Task>> getAllTasks() async {
    Database db = await database;
    List<Map> maps = await db.query(DatabaseHelper._tableName, columns: ['id', 'taskName', 'dueDate', 'priority']);
    
    List<Task> taskList = [];
    if (maps.length > 0 ) {
      for (int i = 0; i<maps.length; i++) {
        taskList.add(Task.fromMap(maps[i]));
      }
    
      taskList.sort((task1, task2) => task1.priority.index.compareTo(task2.priority.index));
      taskList = taskList.reversed.toList();
      return taskList;
    }
  }

  Future<int> delete(int id) async {
    Database db = await database;
    int deletedId = await db.rawDelete('DELETE FROM tasks WHERE id = ?', [id]);
    print('deleted with id: $deletedId');
    return deletedId;
  }




}