import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBType {
  static const PRIMARY_KEY = "INTEGER PRIMARY KEY";
  static const INTEGER = "INTEGER";
  static const TEXT = "TEXT";
  static const DOUBLE = "DOUBLE";
}

class DBInitHelper<T> {
  static Database _db;

  final List<String> dbTablesName;
  final List<Map<String, String>> tablesField;

  DBInitHelper({this.dbTablesName, this.tablesField});

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'taxidriver.db');
    var theDb = await openDatabase(path,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        onDowngrade: _onUpgrade,
        version: 9);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    return _createTable(db, dbTablesName, tablesField);
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion != newVersion) {
      for (var i = 0; i < dbTablesName.length; i++) {
        await db.execute("DROP TABLE IF EXISTS ${dbTablesName[i]}");
      }
      return _createTable(db, dbTablesName, tablesField);
    }
  }

  void _createTable(Database db, List<String> tablesName,
      List<Map<String, String>> tablesFields) {
    List<String> fieldsList = new List();
    String fieldAux;
    for (var item in tablesFields) {
      fieldAux = "";
      item.forEach((field, type) => fieldAux += '$field $type,');
      fieldsList.add(fieldAux.substring(0, fieldAux.length - 1));
    }

    List<String> queries = new List();
    for (var i = 0; i < tablesName.length; i++) {
      String tableName = tablesName[i];
      String fields = fieldsList[i];
      queries.add("CREATE TABLE IF NOT EXISTS $tableName($fields)");
    }
    queries.forEach((q) => db.execute(q));
    return;
  }
}
