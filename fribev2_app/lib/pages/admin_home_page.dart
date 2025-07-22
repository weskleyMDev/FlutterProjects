import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fribev2_app/utils/capitalize_text.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../components/drawer_admin.dart';
import '../stores/auth.store.dart';
import '../stores/sales.store.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  // Future<void> _selectDate(BuildContext context, SalesStore store) async {
  //   final DateTime initialDate = store.selectedDate ?? DateTime.now();
  //   final DateTime firstDate = DateTime(2020);
  //   final DateTime lastDate = DateTime(2101);

  //   final picked = await showDatePicker(
  //     context: context,
  //     initialDate: initialDate,
  //     firstDate: firstDate,
  //     lastDate: lastDate,
  //   );

  //   if (picked != null && picked != store.selectedDate) {
  //     store.selectedDate = picked;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context, listen: false);
    final salesStore = Provider.of<SalesStore>(context, listen: false);
    final name = authStore.currentUser?.email.split('@')[0] ?? 'Usuário';
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem vindo, ${name.capitalize()}!'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined)),
        ],
      ),
      drawer: const DrawerAdmin(),
      body: FutureBuilder(
        future: salesStore.fetchReceipts(),
        builder: (context, asyncSnapshot) {
          return StreamBuilder(
            stream: salesStore.allReceipts,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return const Center(child: Text('Erro ao buscar dados.'));
                  } else {
                    final receipts = snapshot.data ?? [];
                    if (receipts.isEmpty) {
                      return const Center(
                        child: Text('Nenhum recibo encontrado.'),
                      );
                    }
                    return ListView.builder(
                      itemCount: receipts.length,
                      itemBuilder: (context, index) {
                        final receipt = receipts[index];
                        final date = DateFormat(
                          'dd/MM/y - HH:mm',
                        ).format(receipt.createAt);
                        return ListTile(
                          title: Text('Recibo: #${receipt.id}'),
                          subtitle: Text('Data/Hora: $date'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              salesStore.deleteReceiptById(receipt: receipt);
                            },
                          ),
                        );
                      },
                    );
                  }
              }
            },
          );
        }
      ),
    );
  }
}
