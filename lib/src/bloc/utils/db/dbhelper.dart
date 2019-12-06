import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBType {
  static const PRIMARY_KEY = "INTEGER PRIMARY KEY";
  static const INTEGER = "INTEGER";
  static const TEXT = "TEXT";
  static const DOUBLE = "DOUBLE";
}

class DBHelper<T> {
  static Database _db;
  final dbTableName;
  final Map<String, String> tableField;

  DBHelper({this.dbTableName, this.tableField});

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'taxidriver.db');
    var theDb = await openDatabase(path);
    return theDb;
  }

  Future<List<Map<String, dynamic>>> findAll({orderBy}) async {
    var dbClient = await db;
    var query = "SELECT * FROM $dbTableName";
    if (orderBy != null && orderBy != "") {
      query = "$query ORDER BY $orderBy";
    }
    List<Map<String, dynamic>> list = await dbClient.rawQuery(query);
    return list;
  }

  Future<Map<String, dynamic>> findOne({where}) async {
    var dbClient = await db;
    var query = "SELECT * FROM $dbTableName WHERE $where";
    List<Map<String, dynamic>> list = await dbClient.rawQuery(query);
    return list.isNotEmpty ? list.last : {};
  }

  Future<int> saveOne(Map<String, dynamic> values) async {
    var dbClient = await db;
    return dbClient.insert(dbTableName, values,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<int>> saveAll(List<Map<String, dynamic>> valuesList) async {
    var result = <int>[];
    var data = await findAll();
    if (data.length > 0) await clean();
    valuesList.forEach((map) => saveOne(map).then((id) => result.add(id)));
    return result;
  }

  Future<int> update(Map<String, dynamic> values, String id) async {
    var dbClient = await db;
    return dbClient.update(dbTableName, values, where: "id = $id");
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return dbClient.delete(dbTableName, where: "id = $id");
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return dbClient.delete(dbTableName);
  }

  Future<int> clean() async {
    var dbClient = await db;
    return dbClient.delete(dbTableName);
  }
}
