import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/printer_service.dart';

class VouchersScreen extends StatefulWidget {
  const VouchersScreen({super.key});

  @override
  State<VouchersScreen> createState() => _VouchersScreenState();
}

class _VouchersScreenState extends State<VouchersScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final PrinterService _printerService = PrinterService();

  Future<void> _mostrarRecibo(
    String codigoVenda,
    DateTime data,
    List<Map<String, dynamic>> itens,
    List<Map<String, dynamic>> pagamentos,
    double total,
  ) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Recibo de Venda'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fribé Cortes Especiais',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                Text(codigoVenda),
                Text('data: ${DateFormat('dd/MM/yyyy - HH:mm').format(data)}'),
                const SizedBox(height: 8),
                Text(
                  'Formas de pagamento:\n${pagamentos.map((p) => '${p['forma']}: R\$ ${p['valor'].toStringAsFixed(2)}').join('\n')}',
                ),
                const Divider(),
                ...itens.map(
                  (item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      '${item['produto']} x${item['quantidade']}(${item['tipo']}) - R\$ ${(item['preco'] * item['quantidade']).toStringAsFixed(2)}',
                    ),
                  ),
                ),
                const Divider(),
                Text(
                  'TOTAL: R\$ ${total.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await _printerService.printReceipt(
                    codigoVenda: codigoVenda,
                    data: data,
                    itens: itens,
                    pagamentos: pagamentos,
                    total: total,
                  );
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Recibo impresso com sucesso!'),
                    ),
                  );
                } catch (e) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Erro ao imprimir: ${e.toString()}'),
                    ),
                  );
                }
                if (!mounted) return;
                Navigator.of(context).pop();
              },
              child: const Text('Imprimir'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _printerService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Comprovantes")),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('vendas')
            .orderBy('data', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar dados'));
          }

          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty) {
            return const Center(child: Text('Nenhum comprovante encontrado'));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];
              final data = doc['data'] as Timestamp;
              final codigoVenda = doc['codigoVenda'] as String;
              final total = doc['total'] as double;
              final itens = List<Map<String, dynamic>>.from(doc['itens']);
              final pagamentos = List<Map<String, dynamic>>.from(
                doc['pagamentos'],
              );

              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).dividerColor,
                      width: 1.0,
                    ),
                  ),
                ),
                child: ListTile(
                  title: Text('Venda: $codigoVenda'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total: R\$ ${total.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.print),
                    onPressed: () => _mostrarRecibo(
                      codigoVenda,
                      data.toDate(),
                      itens,
                      pagamentos,
                      total,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
