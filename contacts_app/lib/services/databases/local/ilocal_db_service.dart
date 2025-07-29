import 'package:sqflite/sqflite.dart';

import '../../../models/contact.dart';

abstract class ILocalDbService {
  Future<Database?> get db;

  Future<Contact?> getContact({required String id});

  Future<Contact> saveContact({required Contact contact});

  Future<int?> deleteContact({required String id});

  Future<int?> updateContact({required Contact contact});

  Future<List<Contact>> getAllContacts();

  Future<int?> getTotal();

  Future<void> closeDb();
}
