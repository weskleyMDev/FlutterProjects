import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VouchersScreen extends StatefulWidget {
  const VouchersScreen({super.key});

  @override
  State<VouchersScreen> createState() => _VouchersScreenState();
}

class _VouchersScreenState extends State<VouchersScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _mostrarRecibo(
    String codigoVenda,
    List<Map<String, dynamic>> itens,
    String formaPagamento,
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
                Text('Venda: $codigoVenda'),
                const SizedBox(height: 8),
                Text('Forma de pagamento: $formaPagamento'),
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
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Imprimir'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Comprovantes")),
      body: Expanded(
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('vendas').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Erro ao carregar dados'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('Nenhum comprovante encontrado'));
            }

            final vendas = snapshot.data!.docs;

            return ListView.builder(
              itemCount: vendas.length,
              itemBuilder: (context, index) {
                final venda = vendas[index];
                final codigoVenda = venda['codigoVenda'];
                final itens = List<Map<String, dynamic>>.from(venda['itens']);
                final formaPagamento = venda['formaPagamento'];
                final total = venda['total'];

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
                        Text('Forma de pagamento: $formaPagamento'),
                        Text(
                          'Total: R\$ ${total.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.print),
                      onPressed:
                          () => _mostrarRecibo(
                            codigoVenda,
                            itens,
                            formaPagamento,
                            total,
                          ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
