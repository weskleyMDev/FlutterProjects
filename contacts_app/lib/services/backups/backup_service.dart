import 'dart:convert';
import 'dart:io';

import 'package:contacts_app/services/backups/ibackup_service.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class BackupService implements IBackupService {
  @override
  Future<File> createBackup() async {
    final directory = await getApplicationDocumentsDirectory();
    final backupDir = Directory(join(directory.path, 'Backups'));
    if (!await backupDir.exists()) {
      await backupDir.create(recursive: true);
    }
    return File(join(backupDir.path, 'contacts.json'));
  }

  @override
  Future<Map<String, dynamic>?> readBackup() async {
    final file = await createBackup();
    final data = await file.readAsString();
    final map = json.decode(data);
    return map as Map<String, dynamic>;
  }

  @override
  Future<void> saveBackup(Map<String, dynamic> data) async {
    final map = json.encode(data);
    final file = await createBackup();
    await file.writeAsString(map);
  }
}
