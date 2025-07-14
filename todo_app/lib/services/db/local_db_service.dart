import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart' as sqfl;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'idatabase_service.dart';

class LocalDbService implements IDatabaseService {
  @override
  Future<sqfl.Database> startDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = p.join(databasePath, 'todo.db');
    final db = await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        onCreate: (db, version) => db.execute(
          'CREATE TABLE todo(id TEXT PRIMARY KEY, title TEXT, date TEXT)',
        ),
        version: 1,
      ),
    );
    return db;
  }

  @override
  Future<List<Map<String, dynamic>>> getData({
    required String table
  }) async {
    final db = await startDatabase();
    return db.query(table, orderBy: 'title COLLATE NOCASE ASC');
  }

  @override
  Future<void> insertData({
    required String table,
    required Map<String, dynamic> data,
  }) async {
    final db = await startDatabase();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sqfl.ConflictAlgorithm.abort,
    );
  }

  @override
  Future<void> deleteData({required String table, required String id}) async {
    final db = await startDatabase();
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> updateData({
    required String table,
    required Map<String, dynamic> data,
  }) async {
    final db = await startDatabase();
    await db.update(table, data, where: 'id = ?', whereArgs: [data['id']]);
  }

  @override
  Future<void> clearData({required String table}) async {
    final db = await startDatabase();
    await db.delete(table);
  }
}
