import 'dart:convert';
import 'dart:io';

import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:intl/intl.dart';

class PrinterService {
  static final PrinterService _instance = PrinterService._internal();
  factory PrinterService() => _instance;
  PrinterService._internal();

  NetworkPrinter? _printer;
  static String? _printerAddress;
  bool _isConnected = false;

  Future<void> loadConfig() async {
    final configFile = File('assets/config.json');
    if (await configFile.exists()) {
      final configContent = await configFile.readAsString();
      final config = json.decode(configContent);
      _printerAddress = config['printerAddress'];
    } else {
      throw Exception('Config file not found');
    }
  }

  Future<void> connect() async {
    if (_printerAddress == null) {
      await loadConfig();
    }
    try {
      const PaperSize paper = PaperSize.mm80;
      final profile = await CapabilityProfile.load(name: 'default');

      _printer = NetworkPrinter(paper, profile);

      if (_printer == null) {
        throw Exception('Failed to initialize printer');
      }

      final PosPrintResult status = await _printer!.connect(
        _printerAddress!,
        port: 9100,
        timeout: const Duration(seconds: 5),
      );

      if (status != PosPrintResult.success) {
        throw Exception('Failed to connect to printer: ${status.msg}');
      }

      _isConnected = true;
    } catch (e) {
      _printer = null;
      _isConnected = false;
      throw Exception('Error connecting to printer: $e');
    }
  }

  Future<void> printReceipt({
    required String codigoVenda,
    required DateTime data,
    required List<Map<String, dynamic>> itens,
    required List<Map<String, dynamic>> pagamentos,
    required double total,
  }) async {
    try {
      if (_printer == null || !_isConnected) {
        await connect();
      }

      if (_printer == null) {
        throw Exception('Printer initialization failed');
      }

      _printer!.text(
        'Fribe Cortes Especiais',
        styles: const PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
      );
      _printer!.text(
        'CNPJ: XX.XXX.XXX/XXXX-XX',
        styles: const PosStyles(align: PosAlign.center),
      );
      _printer!.hr();

      _printer!.text('Codigo: $codigoVenda');
      _printer!.text('Data: ${DateFormat('dd/MM/yyyy - HH:mm').format(data)}');
      _printer!.hr();

      _printer!.text(
        'ITENS',
        styles: const PosStyles(align: PosAlign.center, bold: true),
      );

      for (var item in itens) {
        _printer!.row([
          PosColumn(
            text: '${item['produto']} x${item['quantidade']}(${item['tipo']})',
            width: 8,
            styles: const PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text:
                'R\$ ${(item['preco'] * item['quantidade']).toStringAsFixed(2)}',
            width: 4,
            styles: const PosStyles(align: PosAlign.right),
          ),
        ]);
      }
      _printer!.hr();

      _printer!.text(
        'PAGAMENTOS',
        styles: const PosStyles(align: PosAlign.center, bold: true),
      );

      for (var pagamento in pagamentos) {
        _printer!.row([
          PosColumn(
            text: '${pagamento['forma']}:',
            width: 6,
            styles: const PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text: 'R\$ ${pagamento['valor'].toStringAsFixed(2)}',
            width: 6,
            styles: const PosStyles(align: PosAlign.right),
          ),
        ]);
      }
      _printer!.hr();

      _printer!.text(
        'TOTAL: R\$ ${total.toStringAsFixed(2)}',
        styles: const PosStyles(
          bold: true,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
      );

      _printer!.feed(2);
      _printer!.text(
        'Obrigado pela preferencia!',
        styles: const PosStyles(align: PosAlign.center),
      );

      _printer!.cut();
    } catch (e) {
      _printer = null;
      _isConnected = false;
      throw Exception('Error during printing: $e');
    }
  }

  void dispose() {
    try {
      if (_isConnected && _printer != null) {
        _printer?.disconnect();
      }
    } catch (e) {
      throw Exception('Error during disconnect: $e');
    }
    _printer = null;
    _isConnected = false;
  }
}
