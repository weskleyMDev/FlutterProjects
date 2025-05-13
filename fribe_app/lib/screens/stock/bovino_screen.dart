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
    _clearFields();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar Item'),
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
                  decoration:
                      const InputDecoration(hintText: 'Quantidade'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: priceController,
                  decoration:
                      const InputDecoration(hintText: 'Preço'),
                  keyboardType: TextInputType.number,
                ),
                DropdownButtonFormField(
                  value: selectedCategory,
                  items: const [
                    DropdownMenuItem(
                      value: 'BOVINO',
                      child: Text('BOVINO'),
                    ),
                    DropdownMenuItem(
                      value: 'SUINO',
                      child: Text('SUINO'),
                    ),
                    DropdownMenuItem(
                      value: 'CAPRINO',
                      child: Text('CAPRINO'),
                    ),
                    DropdownMenuItem(
                      value: 'AVES',
                      child: Text('AVES'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Categoria',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              onPressed: _addItem,
              child: const Text('Salvar'),
            ),
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
      ).showSnackBar(const SnackBar(content: Text("Item added successfully")));
      Navigator.of(context).pop();
    }
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
          stream: collectionRef.where('categoria', isEqualTo: 'BOVINO').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return ListView.builder(
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (context, index) {
          final DocumentSnapshot documentSnapshot =
              streamSnapshot.data!.docs[index];
          final double preco = documentSnapshot['preco'];
          final valor = preco + (preco * 0.3);
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
              title: Text(documentSnapshot['produto']),
              subtitle: Text('Quantidade: ${documentSnapshot['quantidade']}'),
              trailing: Text('Preço: \$${valor.toStringAsFixed(2)}'),
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
