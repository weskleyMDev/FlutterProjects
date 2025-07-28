import 'dart:io';

abstract class IBackupService {
  Future<File> createData();
  Future<Map<String, dynamic>?> readData();
  Future<void> saveData(Map<String, dynamic> data);
}
