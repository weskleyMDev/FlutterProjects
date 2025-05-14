import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VendaScreen extends StatefulWidget {
  const VendaScreen({super.key});

  @override
  State<VendaScreen> createState() => _VendaScreenState();
}

class _VendaScreenState extends State<VendaScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> carrinho = [];
  List<Map<String, dynamic>> produtosFiltrados = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProdutos();
    _searchController.addListener(_filterProdutos);
  }

  List<Map<String, dynamic>> todosProdutos = [];

  Future<void> _loadProdutos() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('EstoqueLoja').get();
    final produtos =
        snapshot.docs.map((doc) {
          final data = doc.data();
          return {
            'codigo': data['codigo'],
            'produto': data['produto'],
            'quantidade': data['quantidade'],
            'preco': data['preco'],
            'categoria': data['categoria'],
          };
        }).toList();

    setState(() {
      todosProdutos = produtos;
      produtosFiltrados = produtos;
      isLoading = false;
    });
  }

  void _filterProdutos() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      produtosFiltrados =
          todosProdutos.where((p) {
            final nomeProduto = (p['produto'] ?? '').toLowerCase();
            final codigoStr = (p['codigo']?.toString() ?? '');

            return nomeProduto.contains(query) || codigoStr.contains(query);
          }).toList();
    });
  }

  void _adicionarAoCarrinho(Map<String, dynamic> produto) {
    final quantidadeController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Quantos itens?"),
          content: TextField(
            controller: quantidadeController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: "Digite a quantidade"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final quantidadeDesejada =
                    int.tryParse(quantidadeController.text) ?? 1;

                final estoqueDisponivel = produto['quantidade'] ?? 0;

                if (quantidadeDesejada <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('A quantidade deve ser maior que zero.'),
                    ),
                  );
                  return;
                }

                setState(() {
                  final existingProductIndex = carrinho.indexWhere(
                    (item) => item['codigo'] == produto['codigo'],
                  );

                  final quantidadeAtualNoCarrinho =
                      (existingProductIndex != -1)
                          ? carrinho[existingProductIndex]['quantidade']
                          : 0;

                  final totalDesejado =
                      quantidadeAtualNoCarrinho + quantidadeDesejada;

                  if (totalDesejado > estoqueDisponivel) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Estoque insuficiente. Só há $estoqueDisponivel unidades disponíveis.',
                        ),
                      ),
                    );
                    return;
                  }

                  if (existingProductIndex != -1) {
                    carrinho[existingProductIndex]['quantidade'] +=
                        quantidadeDesejada;
                  } else {
                    carrinho.add({
                      'codigo': produto['codigo'],
                      'produto': produto['produto'],
                      'preco': produto['preco'],
                      'quantidade': quantidadeDesejada,
                    });
                  }
                });

                Navigator.of(context).pop();
              },
              child: const Text("Adicionar ao Carrinho"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancelar"),
            ),
          ],
        );
      },
    );
  }

  double _totalCarrinho() {
    return carrinho.fold(0.0, (total, item) {
      final preco = item['preco'] ?? 0.0;
      final quantidade = item['quantidade'] ?? 1;
      return total + (preco * quantidade);
    });
  }

  String _gerarCodigoVenda() {
    final now = DateTime.now();
    final data =
        "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}";
    final hora = "${now.hour}${now.minute}${now.second}";
    final random = DateTime.now().millisecondsSinceEpoch % 1000;
    return "VENDA-$data-$hora-$random";
  }

  Future<void> _finalizarVenda() async {
    if (carrinho.isEmpty) return;

    final formaPagamento = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        String selected = 'Dinheiro';

        return AlertDialog(
          title: const Text('Forma de Pagamento'),
          content: DropdownButtonFormField<String>(
            value: selected,
            items:
                ['Dinheiro', 'Cartão', 'Pix', 'Outros']
                    .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                    .toList(),
            onChanged: (value) {
              selected = value!;
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(selected),
              child: const Text('Confirmar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );

    if (formaPagamento == null) return;
    final codigoVenda = _gerarCodigoVenda();

    await FirebaseFirestore.instance.collection('vendas').add({
      'codigoVenda': codigoVenda,
      'itens': carrinho,
      'total': _totalCarrinho(),
      'formaPagamento': formaPagamento,
      'data': DateTime.now(),
    });

    for (var item in carrinho) {
      final querySnapshot =
          await FirebaseFirestore.instance
              .collection('EstoqueLoja')
              .where('codigo', isEqualTo: item['codigo'])
              .limit(1)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        final docRef = querySnapshot.docs.first.reference;
        final data = querySnapshot.docs.first.data();
        final estoqueAtual = data['quantidade'] ?? 0;
        final novaQuantidade = estoqueAtual - item['quantidade'];

        if (novaQuantidade >= 0) {
          await docRef.update({'quantidade': novaQuantidade});
        }
      }
    }

    await _mostrarRecibo(
      codigoVenda,
      carrinho,
      formaPagamento,
      _totalCarrinho(),
    );

    if (!mounted) return;
    setState(() {
      carrinho.clear();
    });
    await _loadProdutos();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Venda $codigoVenda finalizada com sucesso!')),
    );
  }

  Future<void> _mostrarRecibo(
    String codigoVenda,
    List<Map<String, dynamic>> itens,
    String formaPagamento,
    double total,
  ) async {
    showDialog(
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
                      '${item['produto']} x${item['quantidade']} - R\$ ${(item['preco'] * item['quantidade']).toStringAsFixed(2)}',
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
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Venda')),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        labelText: 'Buscar produto',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream:
                          FirebaseFirestore.instance
                              .collection('EstoqueLoja')
                              .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text('Nenhum produto encontrado'),
                          );
                        }

                        final produtos =
                            snapshot.data!.docs
                                .map((doc) {
                                  return {
                                    'codigo': doc['codigo'],
                                    'produto': doc['produto'],
                                    'quantidade': doc['quantidade'],
                                    'preco': doc['preco'],
                                    'categoria': doc['categoria'],
                                  };
                                })
                                .where((produto) {
                                  final nome =
                                      produto['produto']
                                          .toString()
                                          .toLowerCase();
                                  final codigo = produto['codigo'].toString();
                                  final query =
                                      _searchController.text.toLowerCase();
                                  return nome.contains(query) ||
                                      codigo.contains(query);
                                })
                                .toList();

                        if (produtos.isEmpty) {
                          return const Center(
                            child: Text(
                              'Nenhum item encontrado com esse nome ou código.',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: produtos.length,
                          itemBuilder: (context, index) {
                            final produto = produtos[index];
                            return ListTile(
                              leading: CircleAvatar(
                                child: Text(produto['codigo'].toString()),
                              ),
                              title: Text(produto['produto']),
                              subtitle: Row(
                                children: [
                                  Text(
                                    'Preço: R\$ ${produto['preco'].toStringAsFixed(2)}',
                                  ),
                                  const SizedBox(width: 16),
                                  Text('Estoque: ${produto['quantidade']}'),
                                ],
                              ),
                              trailing: ElevatedButton(
                                onPressed: () {
                                  final estoqueDisponivel =
                                      produto['quantidade'] ?? 0;

                                  final itemNoCarrinho = carrinho.firstWhere(
                                    (item) =>
                                        item['codigo'] == produto['codigo'],
                                    orElse: () => {},
                                  );

                                  final quantidadeNoCarrinho =
                                      itemNoCarrinho['quantidade'] ?? 0;

                                  if (estoqueDisponivel == 0 ||
                                      quantidadeNoCarrinho >=
                                          estoqueDisponivel) {
                                    return null;
                                  } else {
                                    return () => _adicionarAoCarrinho(produto);
                                  }
                                }(),
                                child: const Text('Adicionar'),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  _buildCarrinho(),
                ],
              ),
    );
  }

  Widget _buildCarrinho() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Itens no carrinho: ${carrinho.length}'),
          Text('Total: R\$ ${_totalCarrinho().toStringAsFixed(2)}'),
          ListView.builder(
            shrinkWrap: true,
            itemCount: carrinho.length,
            itemBuilder: (context, index) {
              final item = carrinho[index];
              return ListTile(
                title: Text(item['produto']),
                subtitle: Text(
                  'Quantidade: ${item['quantidade']} - Preço: R\$ ${item['preco'].toStringAsFixed(2)}',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      carrinho.removeAt(index);
                    });
                  },
                ),
              );
            },
          ),
          ElevatedButton(
            onPressed: (carrinho.isEmpty) ? null : _finalizarVenda,
            child: const Text('Finalizar Venda'),
          ),
        ],
      ),
    );
  }
}
