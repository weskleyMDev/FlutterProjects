import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VendasScreen extends StatefulWidget {
  const VendasScreen({super.key});

  @override
  State<VendasScreen> createState() => _VendasScreenState();
}

class _VendasScreenState extends State<VendasScreen> {
  final CollectionReference vendasRef = FirebaseFirestore.instance.collection(
    'vendas',
  );

  DateTime? _selectedDate;
  final Map<String, bool> _expandedDates = {};

  Stream<QuerySnapshot> getVendasStream() {
    if (_selectedDate == null) {
      return vendasRef.orderBy('data', descending: true).snapshots();
    }

    final start = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
    );
    final end = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day + 1,
    );

    return vendasRef
        .where('data', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('data', isLessThan: Timestamp.fromDate(end))
        .orderBy('data', descending: true)
        .snapshots();
  }

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      locale: const Locale('pt', 'BR'),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vendas')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.date_range),
                    label: Text(
                      _selectedDate == null
                          ? 'Selecionar data'
                          : 'Data: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                    ),
                    onPressed: _pickDate,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _selectedDate = null;
                      _expandedDates.clear();
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: getVendasStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(child: Text('Erro ao carregar dados.'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('Nenhuma venda encontrada.'));
                }

                final docs = snapshot.data!.docs;
                final Map<String, List<QueryDocumentSnapshot>> groupedVendas =
                    {};

                for (var doc in docs) {
                  final data = (doc['data'] as Timestamp).toDate();
                  final dateKey = DateFormat('dd/MM/yyyy').format(data);

                  groupedVendas.putIfAbsent(dateKey, () => []);
                  groupedVendas[dateKey]!.add(doc);
                }

                final sortedKeys =
                    groupedVendas.keys.toList()..sort(
                      (a, b) => DateFormat(
                        'dd/MM/yyyy',
                      ).parse(b).compareTo(DateFormat('dd/MM/yyyy').parse(a)),
                    );

                return ListView.builder(
                  itemCount: sortedKeys.length,
                  itemBuilder: (context, index) {
                    final dateKey = sortedKeys[index];
                    final isExpanded = _expandedDates[dateKey] ?? false;
                    final vendasDoDia = groupedVendas[dateKey]!;

                    final somaTotalDia = vendasDoDia.fold<double>(
                      0.0,
                      (soma, doc) => soma + (doc['total'] as num).toDouble(),
                    );

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            '📅 $dateKey',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Total do dia: R\$ ${somaTotalDia.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              isExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                            ),
                            onPressed: () {
                              setState(() {
                                _expandedDates[dateKey] = !isExpanded;
                              });
                            },
                          ),
                        ),
                        if (isExpanded)
                          ...vendasDoDia.map((venda) {
                            final data = (venda['data'] as Timestamp).toDate();
                            final total = venda['total'];
                            final formaPagamento = List<Map<String, dynamic>>.from(venda['pagamentos']);
                            final itens = List<Map<String, dynamic>>.from(
                              venda['itens'],
                            );

                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              child: ExpansionTile(
                                title: Text(
                                  'Venda às ${DateFormat('HH:mm').format(data)}',
                                ),
                                subtitle: Text(
                                  'Total: R\$ ${total.toStringAsFixed(2)} • Pagamento: ${formaPagamento.map((p) => '${p['forma']}: R\$ ${p['valor'].toStringAsFixed(2)}').join(', ')}',
                                ),
                                children:
                                    itens.map((item) {
                                      return ListTile(
                                        title: Text(item['produto']),
                                        subtitle: Text(
                                          'Qtd: ${item['quantidade']} • Preço: R\$ ${item['preco'].toStringAsFixed(2)}',
                                        ),
                                        trailing: Text(
                                          'Subtotal: R\$ ${(item['quantidade'] * item['preco']).toStringAsFixed(2)}',
                                        ),
                                      );
                                    }).toList(),
                              ),
                            );
                          }),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
