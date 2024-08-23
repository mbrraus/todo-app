import 'package:sqflite/sqflite.dart';

class TodoDB {
  final tableName = 'todos';

  Future<void> createTable(Database database) async {
    await database.execute('''create table if not exists $tableName (
        id integer primary key autoincrement,
        name text not null,
        isDone integer,
        deadline text,
        priority integer
    )''');

  }


}