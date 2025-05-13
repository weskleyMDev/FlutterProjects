import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fribe_app/services/auth_service.dart';
import 'package:fribe_app/services/db_service.dart';

class BovinoScreen extends StatefulWidget {
  const BovinoScreen({super.key});

  @override
  State<BovinoScreen> createState() => _BovinoScreenState();
}

class _BovinoScreenState extends State<BovinoScreen> {
  final TextEditingController codController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  String selectedCategory = "BOVINO";
  bool isEditing = false;

  final DbService dbService = DbService();
  final AuthService authService = AuthService();

  final CollectionReference collectionRef = FirebaseFirestore.instance
      .collection('estoque');

  void _clearFields() {
    codController.clear();
    nameController.clear();
    quantityController.clear();
    priceController.clear();
  }

  Future<void> _showAddItemDialog() async {
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
                  decoration: const InputDecoration(hintText: 'Código'),
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: 'Produto'),
                ),
                TextField(
                  controller: quantityController,
                  decoration: const InputDecoration(hintText: 'Quantidade'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(hintText: 'Preço'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: TextEditingController(text: selectedCategory),
                  decoration: const InputDecoration(hintText: 'Categoria'),
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
                  decoration: const InputDecoration(hintText: 'Código'),
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: 'Produto'),
                ),
                TextField(
                  controller: quantityController,
                  decoration: const InputDecoration(hintText: 'Quantidade'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(hintText: 'Preço'),
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
    final result = await dbService.addStock(
      codController.text,
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Item adicionado com sucesso")));
      Navigator.of(context).pop();
    }
    _clearFields();
  }

  void _updateItem() {
    dbService.updateStock(
      codController.text,
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
        title: const Text('BOVINO'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              iconSize: 30,
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream:
              collectionRef.where('categoria', isEqualTo: 'BOVINO').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text(
                          documentSnapshot['codigo'].toString(),
                          style: const TextStyle(color: Colors.white),
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
                            Text(
                              'Quantidade: ${documentSnapshot['quantidade']}',
                            ),
                            const SizedBox(width: 10),
                            Text("-"),
                            const SizedBox(width: 10),
                            Text(
                              'Preço: R\$${documentSnapshot['preco'].toStringAsFixed(2)}',
                            ),
                            const SizedBox(width: 10),
                            Text("-"),
                            const SizedBox(width: 10),
                            Text(
                              'Venda: R\$${documentSnapshot['venda'].toStringAsFixed(2)}',
                            ),
                          ],
                        ),
                      ),
                      trailing: IconButton(
                        // show a dropdownmenu with edit and delete options
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
                                      documentSnapshot['codigo'];
                                  nameController.text =
                                      documentSnapshot['produto'];
                                  quantityController.text =
                                      documentSnapshot['quantidade'].toString();
                                  priceController.text =
                                      documentSnapshot['preco'].toString();
                                  selectedCategory =
                                      documentSnapshot['categoria'];
                                  _showEditItemDialog();
                                },
                              ),
                              PopupMenuItem(
                                child: const Text('Deletar'),
                                onTap: () async {
                                  await collectionRef
                                      .doc(documentSnapshot.id)
                                      .delete();
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Item deletado com sucesso',
                                      ),
                                    ),
                                  );
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
            }
            return const Center(child: CircularProgressIndicator());
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
