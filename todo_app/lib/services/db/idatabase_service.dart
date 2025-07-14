import 'package:sqflite/sqflite.dart';

abstract class IDatabaseService {
  Future<Database> startDatabase();
  Future<List<Map<String, dynamic>>> getData({required String table});
  Future<void> insertData({
    required String table,
    required Map<String, dynamic> data,
  });
  Future<void> updateData({
    required String table,
    required Map<String, dynamic> data,
  });
  Future<void> deleteData({required String table, required String id});
  Future<void> clearData({required String table});
}
