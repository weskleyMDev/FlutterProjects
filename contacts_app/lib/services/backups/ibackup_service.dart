abstract class IBackupService {
  Future<String?> readBackup();
  Future<void> saveBackup(List data);
  //Future<void> upsertBackup(Map<String, dynamic> data);
}
