import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'idata_service.dart';

class LocalDataService implements IDataService {
  @override
  Future<File> createData() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/data.json');
  }

  @override
  Future<String?> readData() async {
    try {
      final file = await createData();
      String data = await file.readAsString();
      return data;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveData(List todo) async {
    String data = json.encode(todo);
    final file = await createData();
    await file.writeAsString(data);
  }
}
