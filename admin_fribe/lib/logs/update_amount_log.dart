import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

part 'iupdate_amount_log.dart';

final class UpdateAmountLog implements IUpdateAmountLog {
  @override
  Future<void> writeLog({required String logEntry}) async {
    final directory = await getApplicationDocumentsDirectory();
    final logFile = File('${directory.path}/update_amount_log.txt');

    if (!await logFile.exists()) {
      await logFile.create(recursive: true);
    }

    final now = DateTime.now();
    final currentDate = DateFormat('dd/MM/yyyy').format(now);

    String previousContent = await logFile.readAsString();

    bool shouldWriteHeader = false;

    if (previousContent.trim().isEmpty) {
      shouldWriteHeader = true;
    } else {
      final headerExists = previousContent.contains('=== $currentDate ===');
      if (!headerExists) {
        shouldWriteHeader = true;
      }
    }

    final buffer = StringBuffer();
    if (shouldWriteHeader) {
      if (previousContent.isNotEmpty) {
        buffer.writeln();
      }
      buffer.writeln('=== $currentDate ===');
    }
    buffer.writeln(logEntry);

    await logFile.writeAsString(buffer.toString(), mode: FileMode.append);
  }
}
