import 'dart:io';

abstract class IDataService {
  Future<File> createData();
  Future<void> saveData(List todo);
  Future<String?> readData();
}
