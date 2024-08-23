import 'package:getx_todo/database/todo_db.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/todo.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();

  factory DatabaseService() => _instance;

  Database? _database;

  DatabaseService._internal();
  Future<Database> get database async { //databasei initialiaze ettigimiz yer
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<void> addTodo(Todo todo) async { //database specific, her seferinde butun tabloyu yeniliyor  ? ?
    final db = await database; //
    await db.insert(
      'todos',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<void> deleteTodo(String id) async{
    final db = await database;
    await db.delete('todos',where: 'id = ?',whereArgs: [id] );
  }
  Future<void> updateTodo(Todo todo) async {
    final db = await database;
    await db
        .update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<List<Todo>> getAllTodos() async {
    final db = await database;
    final List<Map<String,dynamic>> dbTodos = await db
        .query('todos');
    return dbTodos.map((todo)=> Todo.fromMap(todo)).toList();
  }




  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(path,
        version: 1, onCreate: create, singleInstance: true);
    return database;
  }
  Future<String> get fullPath async {
    const name = 'todo.db';
    final directory = await getApplicationSupportDirectory();
    return join(directory.path, name);
  }
  Future<void> create(Database database, int version) async =>
      await TodoDB().createTable(database);
  Future<void> printDatabasePath() async {
    final path = await fullPath;
    print('Veritabanı dosyasının tam yolu: $path');
  }



}
