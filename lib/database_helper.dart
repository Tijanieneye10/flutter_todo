import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';

import 'models/task.dart';
import 'models/todo.dart';


  class DatabaseHelper{
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async{
      Directory documentDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentDirectory.path, 'myowntasks.db');

      return await openDatabase(
          path,
          version: 1,
          onCreate: _onCreate,
      );
  }

  Future _onCreate(Database db, int version) async{
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY,
        title TEXT,
        desc TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE todos(
        id INTEGER PRIMARY KEY,
        title TEXT,
        taskId INTEGER,
        isDone INTEGER
      )
    ''');
  }

  Future<List<Task>> getTasks() async{
    Database db = await instance.database;
    var task = await db.query('tasks', orderBy: 'title');

    List<Task> taskList = task.isNotEmpty
        ? task.map((c) => Task.fromMap(c)).toList()
        : [];
    return taskList;
  }



  Future<List<Todo>> getTodo(int? id) async{
    Database db = await instance.database;
    var todo = await db.query('todos', where: 'taskId = ?', whereArgs: [id]);


    List<Todo> todoList = todo.isNotEmpty
        ? todo.map((c) => Todo.fromMap(c)).toList()
        : [];
    return todoList;
  }

  Future<int> add(Task task) async{
    int taskId = 0;
    Database db = await instance.database;
    await db.insert('tasks', task.toMap()).then((value){
      taskId = value;
    });
    return taskId;
  }

  Future<int> updateTask(Task task) async{
    Database db = await instance.database;
    return await db.update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<int> updateTodo(int? id, int isDone) async{
    Database db = await instance.database;
    return db.rawUpdate("UPDATE todos SET isDone = '$isDone' WHERE id = '$id' ");
  }

  Future<int> deleteTaskandTodo(int? id) async{
    Database db = await instance.database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
    return db.delete('todos', where: 'taskId = ?', whereArgs: [id]);
  }

//  for Todo
  Future<int> addTodo(Todo todo) async{
    Database db = await instance.database;
    return await db.insert('todos', todo.toMap());
  }
}