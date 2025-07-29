import 'dart:io';

import 'package:contacts_app/services/databases/local/ilocal_db_service.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../models/contact.dart';

class LocalDbService implements ILocalDbService {
  Database? _db;

  @override
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await _initDb();
      return _db;
    }
  }

  Future<Database?> _initDb() async {
    final directory = await getApplicationSupportDirectory();
    final databaseDir = Directory(join(directory.path, 'Database'));
    if (!await databaseDir.exists()) {
      await databaseDir.create(recursive: true);
    }
    final path = join(databaseDir.path, 'contacts.db');
    _db = await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        onCreate: (db, version) async => await db.execute(
          'CREATE TABLE IF NOT EXISTS contacts(id TEXT PRIMARY KEY, name TEXT, email TEXT, phone TEXT, imagePath TEXT)',
        ),
        version: 1,
      ),
    );
    return _db;
  }

  @override
  Future<Contact?> getContact({required String id}) async {
    final database = await db;
    final data = await database?.query(
      'contacts',
      columns: ['id', 'name', 'email', 'phone', 'imagePath'],
      where: 'id = ?',
      whereArgs: [id],
    );
    if (data != null && data.isNotEmpty) {
      return Contact.fromMap(data.first);
    } else {
      return null;
    }
  }

  @override
  Future<Contact> saveContact({required Contact contact}) async {
    final database = await db;
    await database?.insert('contacts', contact.toMap());
    return contact;
  }

  @override
  Future<int?> deleteContact({required String id}) async {
    final database = await db;
    final deleted = await database?.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
    return deleted;
  }

  @override
  Future<int?> updateContact({required Contact contact}) async {
    final database = await db;
    final changes = await database?.update(
      'contacts',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
    return changes;
  }

  @override
  Future<List<Contact>> getAllContacts() async {
    final database = await db;
    final data = await database?.rawQuery('SELECT * FROM contacts');
    List<Contact> contacts = [];
    if (data != null) {
      contacts = data.map((e) => Contact.fromMap(e)).toList();
    }
    return contacts;
  }

  @override
  Future<int?> getTotal() async {
    final database = await db;
    int? data;
    if (database != null) {
      data = Sqflite.firstIntValue(
        await database.rawQuery('SELECT COUNT(*) FROM contacts'),
      );
    }
    return data;
  }

  @override
  Future<void> closeDb() async {
    final database = await db;
    await database?.close();
  }
}
