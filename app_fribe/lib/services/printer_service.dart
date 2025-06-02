import 'dart:io';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:intl/intl.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart' as esc;
import 'package:esc_pos_printer/esc_pos_printer.dart';

class PrinterService {
  static final PrinterService _instance = PrinterService._internal();
  factory PrinterService() => _instance;
  PrinterService._internal();

  bool _isConnected = false;
  Socket? _printerSocket;
  NetworkPrinter? _androidPrinter;
  int _retryCount = 0;
  static const int maxRetries = 3;
  static const Duration connectionTimeout = Duration(seconds: 10);
  static const Duration retryDelay = Duration(seconds: 2);

  static const String printerIp = '192.168.0.92';
  static const int printerPort = 9100;

  Future<void> connect() async {
    if (_isConnected && (_printerSocket != null || _androidPrinter != null)) {
      return;
    }

    _retryCount = 0;
    while (_retryCount < maxRetries) {
      try {
        if (Platform.isWindows) {
          try {
            final socket = await Socket.connect(
              printerIp,
              printerPort,
              timeout: const Duration(seconds: 1),
            );
            await socket.close();
          } catch (e) {
            throw Exception('Porta da impressora não está acessível: $e');
          }

          _printerSocket = await Socket.connect(
            printerIp,
            printerPort,
            timeout: connectionTimeout,
          );
          _isConnected = true;
          _retryCount = 0;
          return;
        } else if (Platform.isAndroid) {
          final printer = NetworkPrinter(
            PaperSize.mm80,
            await CapabilityProfile.load(),
          );

          final PosPrintResult result = await printer.connect(
            printerIp,
            port: printerPort,
            timeout: connectionTimeout,
          );

          if (result == PosPrintResult.success) {
            _androidPrinter = printer;
            _isConnected = true;
          } else {
            throw Exception('Failed to connect: ${result.msg}');
          }
        }

        _retryCount = 0;
        return;
      } catch (e) {
        _retryCount++;
        if (_retryCount >= maxRetries) {
          _isConnected = false;
          if (_printerSocket != null) {
            await _printerSocket!.close();
          }
          _printerSocket = null;
          _androidPrinter?.disconnect();
          _androidPrinter = null;
          throw Exception(
            'Erro ao conectar à impressora após $maxRetries tentativas: $e',
          );
        }
        await Future.delayed(retryDelay);
      }
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
      await connect();

      final profile = await esc.CapabilityProfile.load();
      final generator = esc.Generator(esc.PaperSize.mm80, profile);
      List<int> bytes = [];

      bytes += generator.text(
        'Fribe Cortes Especiais',
        styles: const esc.PosStyles(
          align: esc.PosAlign.center,
          height: esc.PosTextSize.size2,
          width: esc.PosTextSize.size2,
        ),
      );

      bytes += generator.text(
        'CNPJ: XX.XXX.XXX/XXXX-XX',
        styles: const esc.PosStyles(align: esc.PosAlign.center),
      );
      bytes += generator.hr(ch: '-', len: 48);

      bytes += generator.text('Codigo: $codigoVenda');
      bytes += generator.text(
        'Data: ${DateFormat('dd/MM/yyyy - HH:mm').format(data)}',
      );
      bytes += generator.hr(ch: '-', len: 48);

      bytes += generator.text(
        'ITENS',
        styles: const esc.PosStyles(align: esc.PosAlign.center, bold: true),
      );

      for (var item in itens) {
        final produto =
            item['produto'] as String? ?? 'Produto não especificado';
        final quantidade = item['quantidade'] as num? ?? 0;
        final tipo = item['tipo'] as String? ?? 'UN';
        final preco = (item['preco'] as num? ?? 0.0) * quantidade;
        final linha = linhaComValorDireita(
          '$produto x$quantidade($tipo)',
          'R\$ ${preco.toStringAsFixed(2)}',
          largura: 48,
        );
        bytes += generator.text(
          linha,
          styles: const esc.PosStyles(align: esc.PosAlign.left),
        );
      }
      bytes += generator.hr(ch: '-', len: 48);

      bytes += generator.text(
        'PAGAMENTOS',
        styles: const esc.PosStyles(align: esc.PosAlign.center, bold: true),
      );

      for (var pagamento in pagamentos) {
        final forma = pagamento['forma'] as String? ?? 'Forma não especificada';
        final valor = pagamento['valor'] as num? ?? 0.0;
        final linha = linhaComValorDireita(
          '$forma:',
          'R\$ ${valor.toStringAsFixed(2)}',
          largura: 48,
        );
        bytes += generator.text(
          linha,
          styles: const esc.PosStyles(align: esc.PosAlign.left),
        );
      }
      bytes += generator.hr(ch: '-', len: 48);

      bytes += generator.text(
        'TOTAL: R\$ ${total.toStringAsFixed(2)}',
        styles: const esc.PosStyles(
          bold: true,
          height: esc.PosTextSize.size2,
          width: esc.PosTextSize.size2,
        ),
      );

      bytes += generator.feed(2);
      bytes += generator.text(
        'Obrigado pela preferencia!',
        styles: const esc.PosStyles(align: esc.PosAlign.center),
      );

      bytes += generator.cut();

      if (Platform.isWindows && _printerSocket != null) {
        try {
          _printerSocket!.add(bytes);
          await _printerSocket!.flush();
          await _printerSocket!.close();
          _printerSocket = null;
          _isConnected = false;
        } catch (e) {
          throw Exception('Erro ao enviar dados para impressora: $e');
        }
      } else if (Platform.isAndroid && _androidPrinter != null) {
        _androidPrinter!.rawBytes(bytes);
      } else {
        throw Exception('Nenhuma conexão com impressora disponível');
      }
    } catch (e) {
      _isConnected = false;
      _printerSocket?.destroy();
      _printerSocket = null;
      _androidPrinter?.disconnect();
      _androidPrinter = null;
      throw Exception('Erro ao imprimir: $e');
    }
  }

  void dispose() {
    _isConnected = false;
    _printerSocket?.destroy();
    _printerSocket = null;
    _androidPrinter?.disconnect();
    _androidPrinter = null;
  }

  String linhaComValorDireita(
    String esquerda,
    String direita, {
    int largura = 48,
  }) {
    esquerda = esquerda.replaceAll('\n', '');
    direita = direita.replaceAll('\n', '');
    int espacos = largura - esquerda.length - direita.length;
    if (espacos < 1) espacos = 1;
    return esquerda + ' ' * espacos + direita;
  }
}
