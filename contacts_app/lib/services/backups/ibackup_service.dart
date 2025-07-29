import 'dart:io';

abstract class IBackupService {
  Future<File> createBackup();
  Future<Map<String, dynamic>?> readBackup();
  Future<void> saveBackup(Map<String, dynamic> data);
}
