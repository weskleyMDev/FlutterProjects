import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VendaScreen extends StatefulWidget {
  const VendaScreen({super.key});

  @override
  State<VendaScreen> createState() => _VendaScreenState();
}

class _VendaScreenState extends State<VendaScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> carrinho = [];
  List<Map<String, dynamic>> produtosFiltrados = [];

  double _formatNumber(double value) {
    return double.parse(value.toStringAsFixed(2));
  }

  @override
  void initState() {
    super.initState();
    _loadProdutos();
    _searchController.addListener(_filterProdutos);
  }

  List<Map<String, dynamic>> todosProdutos = [];

  Future<void> _loadProdutos() async {
    final snapshot = await _firestore.collection('EstoqueLoja').get();
    final produtos =
        snapshot.docs.map((doc) {
          final data = doc.data();
          return {
            'codigo': data['codigo'],
            'produto': data['produto'],
            'quantidade': data['quantidade'],
            'tipo': data['tipo'],
            'preco': data['preco'],
            'categoria': data['categoria'],
          };
        }).toList();

    setState(() {
      todosProdutos = produtos;
      produtosFiltrados = produtos;
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
        final isKg = (produto['tipo']?.toString().toUpperCase() == 'KG');
        return AlertDialog(
          title: Text(isKg ? "Quantos KG?" : "Quantos itens?"),
          content: TextField(
            controller: quantidadeController,
            keyboardType: TextInputType.numberWithOptions(decimal: isKg),
            decoration: InputDecoration(
              hintText:
                  isKg
                      ? "Digite a quantidade em KG (ex: 0.5)"
                      : "Digite a quantidade",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                final estoqueDisponivel = produto['quantidade'] ?? 0;
                double quantidadeDesejada;
                if (isKg) {
                  quantidadeDesejada =
                      double.tryParse(
                        quantidadeController.text.replaceAll(',', '.'),
                      ) ??
                      1.0;
                  quantidadeDesejada = double.parse(
                    _formatNumber(quantidadeDesejada).toString(),
                  );
                  if (quantidadeDesejada <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('A quantidade deve ser maior que zero.'),
                      ),
                    );
                    return;
                  }

                  final existingProductIndex = carrinho.indexWhere(
                    (item) => item['codigo'] == produto['codigo'],
                  );
                  final quantidadeAtualNoCarrinho =
                      (existingProductIndex != -1)
                          ? (carrinho[existingProductIndex]['quantidade']
                              as double)
                          : 0.0;
                  final totalDesejado =
                      quantidadeAtualNoCarrinho + quantidadeDesejada;
                  if (totalDesejado > estoqueDisponivel) {
                    final quantidadeDisponivel = _formatNumber(
                      estoqueDisponivel - quantidadeAtualNoCarrinho,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Estoque insuficiente. Só há $quantidadeDisponivel kg disponíveis.',
                        ),
                      ),
                    );
                    return;
                  }
                  setState(() {
                    if (existingProductIndex != -1) {
                      carrinho[existingProductIndex]['quantidade'] +=
                          quantidadeDesejada;
                    } else {
                      carrinho.add({
                        'codigo': produto['codigo'],
                        'produto': produto['produto'],
                        'preco': produto['preco'],
                        'quantidade': quantidadeDesejada,
                        'tipo': produto['tipo'],
                      });
                    }
                  });
                } else {
                  final quantidadeInt =
                      int.tryParse(quantidadeController.text) ?? 1;
                  if (quantidadeInt <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('A quantidade deve ser maior que zero.'),
                      ),
                    );
                    return;
                  }
                  final existingProductIndex = carrinho.indexWhere(
                    (item) => item['codigo'] == produto['codigo'],
                  );
                  final quantidadeAtualNoCarrinho =
                      (existingProductIndex != -1)
                          ? carrinho[existingProductIndex]['quantidade']
                          : 0;
                  final totalDesejado =
                      quantidadeAtualNoCarrinho + quantidadeInt;
                  if (totalDesejado > estoqueDisponivel) {
                    final quantidadeDisponivel =
                        estoqueDisponivel - quantidadeAtualNoCarrinho;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Estoque insuficiente. Só há $quantidadeDisponivel unidades disponíveis.',
                        ),
                      ),
                    );
                    return;
                  }
                  setState(() {
                    if (existingProductIndex != -1) {
                      carrinho[existingProductIndex]['quantidade'] +=
                          quantidadeInt;
                    } else {
                      carrinho.add({
                        'codigo': produto['codigo'],
                        'produto': produto['produto'],
                        'preco': produto['preco'],
                        'quantidade': quantidadeInt,
                        'tipo': produto['tipo'],
                      });
                    }
                  });
                }

                Navigator.of(context).pop();
              },
              child: const Text("Adicionar ao Carrinho"),
            ),
          ],
        );
      },
    );
  }

  double _totalCarrinho() {
    final total = carrinho.fold(0.0, (total, item) {
      final preco = item['preco'] ?? 0.0;
      final quantidade = item['quantidade'] ?? 1;
      return total + (preco * quantidade);
    });
    return _formatNumber(total);
  }

  String _gerarCodigoVenda() {
    final now = DateTime.now();

    final data =
        "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}";

    final hora =
        "${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}";

    final random = Random().nextInt(1000);

    return "VENDA-$data-$hora-${random.toString().padLeft(3, '0')}";
  }

  Future<void> _finalizarVenda() async {
    if (carrinho.isEmpty) return;
    List<Map<String, dynamic>> pagamentos = [];
    final total = _totalCarrinho();

    final confirmado = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        String selectedForma = 'Dinheiro';
        final TextEditingController valorController = TextEditingController();
        List<Map<String, dynamic>> pagamentosTemp = [];
        double totalParcial = 0.0;

        return StatefulBuilder(
          builder: (context, setState) {
            totalParcial = _formatNumber(
              pagamentosTemp.fold(0.0, (acc, p) => acc + p['valor']),
            );
            final restante = _formatNumber(total - totalParcial);

            void adicionarPagamento() {
              final input = valorController.text.replaceAll(',', '.');
              double valor = double.tryParse(input) ?? 0.0;
              valor = _formatNumber(valor);
              if (valor <= 0 || valor > restante) return;

              setState(() {
                pagamentosTemp.add({'forma': selectedForma, 'valor': valor});
                valorController.clear();
              });
            }

            return AlertDialog(
              title: const Text('Formas de Pagamento'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<String>(
                      value: selectedForma,
                      items:
                          ['Dinheiro', 'Debito', 'Credito', 'Pix']
                              .map(
                                (f) =>
                                    DropdownMenuItem(value: f, child: Text(f)),
                              )
                              .toList(),
                      onChanged: (value) {
                        setState(() => selectedForma = value!);
                      },
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: valorController,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Valor Recebido',
                        prefixText: 'R\$ ',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: restante <= 0 ? null : adicionarPagamento,
                      child: const Text('Receber'),
                    ),
                    const SizedBox(height: 12),
                    if (pagamentosTemp.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Column(
                        children:
                            pagamentosTemp.map((p) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${p['forma']}: R\$ ${_formatNumber(p['valor'])}',
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        pagamentosTemp.remove(p);
                                      });
                                    },
                                  ),
                                ],
                              );
                            }).toList(),
                      ),
                    ],
                    const Divider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Informado: R\$ ${_formatNumber(totalParcial)}',
                        ),
                        Text('Total Restante: R\$ $restante'),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    if (totalParcial < total) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Total insuficiente. Faltam R\$ ${_formatNumber(total - totalParcial)}',
                          ),
                        ),
                      );
                      return;
                    }
                    pagamentos = List<Map<String, dynamic>>.from(
                      pagamentosTemp,
                    );
                    Navigator.of(context).pop(true); // Fecha o diálogo
                  },
                  child: const Text('Confirmar'),
                ),
              ],
            );
          },
        );
      },
    );

    if (confirmado != true) return;

    if (pagamentos.isEmpty ||
        pagamentos.fold(0.0, (s, p) => s + p['valor']) < total) {
      return;
    }
    final codigoVenda = _gerarCodigoVenda();

    await _firestore.collection('vendas').add({
      'codigoVenda': codigoVenda,
      'itens': carrinho,
      'total': _formatNumber(total),
      'pagamentos': pagamentos,
      'data': DateTime.now(),
    });

    for (var item in carrinho) {
      final querySnapshot =
          await _firestore
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

    await _mostrarRecibo(codigoVenda, carrinho, pagamentos, total);

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
                Text('Venda: $codigoVenda'),
                const SizedBox(height: 8),
                const Text(
                  'Formas de Pagamento:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ...pagamentos.map(
                  (p) =>
                      Text('${p['forma']}: R\$ ${_formatNumber(p['valor'])}'),
                ),
                const Divider(),
                ...itens.map(
                  (item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      '${item['produto']} x${item['quantidade']} (${item['tipo']}) - '
                      'R\$ ${_formatNumber(item['preco'] * item['quantidade'])}',
                    ),
                  ),
                ),
                const Divider(),
                Text(
                  'TOTAL: R\$ ${_formatNumber(total)}',
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
      body: Column(
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
              stream: _firestore.collection('EstoqueLoja').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('Nenhum produto encontrado'));
                }

                final produtos =
                    snapshot.data!.docs
                        .map((doc) {
                          return {
                            'codigo': doc['codigo'],
                            'produto': doc['produto'],
                            'quantidade': doc['quantidade'],
                            'tipo': doc['tipo'],
                            'preco': doc['preco'],
                            'categoria': doc['categoria'],
                          };
                        })
                        .where((produto) {
                          final nome =
                              produto['produto'].toString().toLowerCase();
                          final codigo = produto['codigo'].toString();
                          final query = _searchController.text.toLowerCase();
                          return nome.contains(query) || codigo.contains(query);
                        })
                        .toList();

                produtos.sort(
                  (a, b) => (a['codigo'] as int).compareTo(b['codigo'] as int),
                );

                if (produtos.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhum item encontrado com esse nome ou código.',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: produtos.length,
                  itemBuilder: (context, index) {
                    final produto = produtos[index];
                    final isKg =
                        (produto['tipo']?.toString().toUpperCase() == 'KG');
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(produto['codigo'].toString()),
                      ),
                      title: Text(produto['produto']),
                      subtitle: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text(
                              'Preço: R\$ ${_formatNumber(produto['preco'])}',
                            ),
                            const SizedBox(width: 6),
                            const Text('-'),
                            const SizedBox(width: 6),
                            Text(
                              isKg
                                  ? 'Estoque: ${NumberFormat('#,##0.00', 'pt_BR').format(produto['quantidade'])} (${produto['tipo']})'
                                  : 'Estoque: ${produto['quantidade']} (${produto['tipo']})',
                            ),
                          ],
                        ),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          final estoqueDisponivel = _formatNumber(
                            (produto['quantidade'] ?? 0).toDouble(),
                          );
                          final isKg =
                              produto['tipo']?.toString().toUpperCase() == 'KG';

                          final itemNoCarrinho = carrinho.firstWhere(
                            (item) => item['codigo'] == produto['codigo'],
                            orElse: () => {},
                          );

                          final quantidadeNoCarrinho = _formatNumber(
                            (itemNoCarrinho['quantidade'] ?? 0).toDouble(),
                          );

                          if (estoqueDisponivel == 0) {
                            return null;
                          }

                          if (isKg) {
                            final pesoZerado =
                                quantidadeNoCarrinho - estoqueDisponivel;
                            if (pesoZerado == 0) {
                              return null;
                            }
                          } else {
                            if (quantidadeNoCarrinho >= estoqueDisponivel) {
                              return null;
                            }
                          }

                          return () => _adicionarAoCarrinho(produto);
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
            width: 1.0,
          ),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.45,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Itens no carrinho: ${carrinho.length}'),
                  Text(
                    style: TextStyle(fontWeight: FontWeight.bold),
                    'Total: R\$ ${_formatNumber(_totalCarrinho())}',
                  ),
                ],
              ),
              IconButton(
                onPressed:
                    (carrinho.isEmpty)
                        ? null
                        : () {
                          setState(() {
                            carrinho.clear();
                          });
                        },
                icon: Icon(Icons.cleaning_services_rounded),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: carrinho.length,
              itemBuilder: (context, index) {
                final item = carrinho[index];
                return ListTile(
                  leading: Text(
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    '${index + 1}',
                  ),
                  title: Text(item['produto']),
                  subtitle: Text(
                    item['tipo'] == 'KG'
                        ? 'Quantidade: ${NumberFormat('#,##0.00', 'pt_BR').format(item['quantidade'])} (${item['tipo']}) - Preço: R\$ ${_formatNumber(item['preco'])}'
                        : 'Quantidade: ${item['quantidade']} (${item['tipo']}) - Preço: R\$ ${_formatNumber(item['preco'])}',
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
