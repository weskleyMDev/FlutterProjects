import 'dart:convert';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';

class PrinterService {
  static final PrinterService _instance = PrinterService._internal();
  factory PrinterService() => _instance;
  PrinterService._internal();

  NetworkPrinter? _printer;
  String? _printerAddress;
  int? _printerPort;
  bool _isConnected = false;

  Future<void> loadConfig() async {
    try {
      final configContent = await rootBundle.loadString('assets/config.json');
      final config = json.decode(configContent);
      _printerAddress = config['printerAddress'];
      _printerPort = config['printerPort'];
    } catch (e) {
      throw Exception('Erro ao carregar configurações: $e');
    }
  }

  Future<bool> _testConnection(String host, int port) async {
    try {
      final socket = await Socket.connect(
        host,
        port,
        timeout: const Duration(seconds: 5),
      );
      await socket.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> connect() async {
    if (_printerAddress == null) {
      await loadConfig();
    }

    try {

      if (!await _testConnection(_printerAddress!, _printerPort!)) {
        throw Exception(
          'Não foi possível conectar à impressora.\n'
          'Verifique:\n'
          '1. Se a impressora está ligada\n'
          '2. Se está na mesma rede\n'
          '3. Se o IP $_printerAddress está correto',
        );
      }

      const PaperSize paper = PaperSize.mm80;
      final profile = await CapabilityProfile.load(name: 'default');
      _printer = NetworkPrinter(paper, profile);

      final status = await _printer!.connect(
        _printerAddress!,
        port: _printerPort!,
        timeout: const Duration(seconds: 5),
      );

      if (status != PosPrintResult.success) {
        throw Exception('Falha ao conectar: ${status.msg}');
      }

      _isConnected = true;
    } catch (e) {
      _printer = null;
      _isConnected = false;
      throw Exception('Erro: $e');
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
          PosColumn(text: '${pagamento['forma']}:', width: 6),
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
      throw Exception('Erro ao imprimir: $e');
    }
  }

  void dispose() {
    try {
      if (_isConnected && _printer != null) {
        _printer?.disconnect();
      }
    } catch (e) {
      throw Exception('Erro ao desconectar: $e');
    }
    _printer = null;
    _isConnected = false;
  }
}
