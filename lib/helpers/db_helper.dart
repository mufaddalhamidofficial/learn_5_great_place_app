import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  Future<sql.Database> database(String table) async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'main.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $table(id TEXT PRIMARY KEY, title TEXT, image TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final sqlDB = await DBHelper().database(table);
    await sqlDB.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, Object>>> getData(String table) async {
    final sqlDB = await DBHelper().database(table);
    return sqlDB.query(table);
  }
}
