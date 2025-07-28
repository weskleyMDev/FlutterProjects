import 'dart:convert';
import 'dart:io';

import 'package:contacts_app/services/backups/ibackup_service.dart';
import 'package:path_provider/path_provider.dart';

class BackupService implements IBackupService {
  @override
  Future<File> createData() async {
    final directory = await getApplicationDocumentsDirectory();
    final backupDir = Directory('${directory.path}/Backups');
    if (!await backupDir.exists()) {
      await backupDir.create(recursive: true);
    }
    return File('${backupDir.path}/contacts.json');
  }

  @override
  Future<Map<String, dynamic>?> readData() async {
    final file = await createData();
    final data = await file.readAsString();
    final map = json.decode(data);
    return map as Map<String, dynamic>;
  }

  @override
  Future<void> saveData(Map<String, dynamic> data) async {
    final map = json.encode(data);
    final file = await createData();
    await file.writeAsString(map);
  }
}
