import 'dart:convert';
import 'dart:io';

import 'package:contacts_app/services/backups/ibackup_service.dart';
import 'package:path_provider/path_provider.dart';

class BackupService implements IBackupService {
  Future<File> _createBackup() async {
    try {
      final directory = await getApplicationSupportDirectory();

      final backupDir = Directory('${directory.path}/Backups');

      if (!await backupDir.exists()) {
        await backupDir.create(recursive: true);
      }

      return File('${backupDir.path}/contacts.json');
    } catch (e) {
      throw Exception(
        'Erro ao criar arquivo de backup: ${e.toString().replaceAll('Exception: ', '')}',
      );
    }
  }

  @override
  Future<String?> readBackup() async {
    try {
      final file = await _createBackup();
      String data = await file.readAsString();
      return data;
    } catch (e) {
      throw Exception(
        'Erro ao ler arquivo de backup: ${e.toString().replaceAll('Exception: ', '')}',
      );
    }
  }

  @override
  Future<void> saveBackup(List data) async {
    try {
      String jsonString = json.encode(data);
      final file = await _createBackup();
      await file.writeAsString(jsonString);
    } catch (e) {
      throw Exception(
        'Erro ao salvar arquivo de backup: ${e.toString().replaceAll('Exception: ', '')}',
      );
    }
  }
}
