import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../../services/db_service.dart';

class SuinoScreen extends StatefulWidget {
  const SuinoScreen({super.key});

  @override
  State<SuinoScreen> createState() => _SuinoScreenState();
}

class _SuinoScreenState extends State<SuinoScreen> {
  final TextEditingController codController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  String selectedCategory = "SUINO";
  bool isSearching = false;

  final DbService dbService = DbService();
  final AuthService authService = AuthService();

  final CollectionReference collectionRef = FirebaseFirestore.instance
      .collection('EstoqueLoja');

  void _clearFields() {
    codController.clear();
    nameController.clear();
    quantityController.clear();
    priceController.clear();
  }

  Future<void> _showAddItemDialog() async {
    int nextCode = await dbService.getCurrentCode();
    codController.text = nextCode.toString();
    if (!mounted) return;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adicionar Item'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: codController,
                  decoration: const InputDecoration(labelText: 'Código'),
                  keyboardType: TextInputType.number,
                  readOnly: true,
                  enabled: false,
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Produto'),
                ),
                TextField(
                  controller: quantityController,
                  decoration: const InputDecoration(labelText: 'Quantidade'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Preço'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: TextEditingController(text: selectedCategory),
                  decoration: const InputDecoration(labelText: 'Categoria'),
                  readOnly: true,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
                _clearFields();
              },
            ),
            TextButton(onPressed: _addItem, child: const Text('Salvar')),
          ],
        );
      },
    );
  }

  Future<void> _showEditItemDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Item'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: codController,
                  decoration: const InputDecoration(labelText: 'Código'),
                  keyboardType: TextInputType.number,
                  enabled: false,
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Produto'),
                  enabled: false,
                ),
                TextField(
                  controller: quantityController,
                  decoration: const InputDecoration(labelText: 'Quantidade'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Preço'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
                _clearFields();
              },
            ),
            TextButton(onPressed: _updateItem, child: const Text('Atualizar')),
          ],
        );
      },
    );
  }

  void _addItem() async {
    int nextCode = int.parse(codController.text);
    final result = await dbService.addStock(
      nextCode,
      nameController.text,
      int.parse(quantityController.text),
      double.parse(priceController.text),
      selectedCategory,
    );
    if (!mounted) return;
    if (result != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $result")));
    } else {
      await dbService.incrementCode();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Item adicionado com sucesso")),
      );
      Navigator.of(context).pop();
    }
    _clearFields();
  }

  void _updateItem() {
    dbService.updateStock(
      int.parse(codController.text),
      int.parse(quantityController.text),
      double.parse(priceController.text),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Item atualizado com sucesso")),
    );
    Navigator.of(context).pop();
    _clearFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            isSearching
                ? TextField(
                  controller: searchController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Pesquisar...',
                    filled: true,
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                )
                : const Text('SUINO'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              iconSize: 30,
              icon: Icon(isSearching ? Icons.close : Icons.search),
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                  if (!isSearching) {
                    searchController.clear();
                  }
                });
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream:
              collectionRef.where('categoria', isEqualTo: 'SUINO').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!streamSnapshot.hasData || streamSnapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  'Nenhum item encontrado',
                  style: TextStyle(fontSize: 20),
                ),
              );
            }
            final filteredDocs =
                streamSnapshot.data!.docs.where((doc) {
                  final code = doc['codigo'].toString();
                  final productName = doc['produto'].toString().toLowerCase();
                  final searchTerm = searchController.text.toLowerCase();
                  return productName.contains(searchTerm) ||
                      code.contains(searchTerm);
                }).toList();
            if (filteredDocs.isEmpty) {
              return const Center(child: Text("Nenhum item correspondente"));
            }
            return ListView.builder(
              itemCount: filteredDocs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot = filteredDocs[index];
                return Card(
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        documentSnapshot['codigo'].toString(),
                      ),
                    ),
                    title: Text(
                      documentSnapshot['produto'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text('Quantidade: ${documentSnapshot['quantidade']}'),
                          const SizedBox(width: 10),
                          Text("-"),
                          const SizedBox(width: 10),
                          Text(
                            'Preço: R\$${documentSnapshot['preco'].toStringAsFixed(2)}',
                          ),
                        ],
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(100, 100, 0, 0),
                          items: [
                            PopupMenuItem(
                              child: const Text('Editar'),
                              onTap: () {
                                codController.text =
                                    documentSnapshot['codigo'].toString();
                                nameController.text =
                                    documentSnapshot['produto'];
                                quantityController.text = '1';
                                priceController.text =
                                    documentSnapshot['preco'].toString();
                                selectedCategory =
                                    documentSnapshot['categoria'];
                                _showEditItemDialog();
                              },
                            ),
                            PopupMenuItem(
                              child: const Text('Deletar'),
                              onTap: () {
                                Future.delayed(const Duration(), () async {
                                  if (!context.mounted) return;
                                  await showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Confirmar Exclusão'),
                                        content: const Text(
                                          'Tem certeza que deseja deletar este item?',
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Cancelar'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text('Deletar'),
                                            onPressed: () async {
                                              await collectionRef
                                                  .doc(documentSnapshot.id)
                                                  .delete();
                                              if (!context.mounted) return;
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'Item deletado com sucesso',
                                                  ),
                                                ),
                                              );
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                });
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              },
            );
            //return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddItemDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}