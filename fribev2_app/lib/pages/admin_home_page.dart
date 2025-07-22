import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fribev2_app/utils/capitalize_text.dart';
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
    final authStore = Provider.of<AuthStore>(context);
    final salesStore = Provider.of<SalesStore>(context);
    final name = authStore.currentUser?.email.split('@')[0] ?? 'Usuário';

    return Scaffold(
      appBar: AppBar(
        title: Text('Bem vindo, ${name.capitalize()}!'),
        actions: [
          // IconButton(
          //   onPressed: () => _selectDate(context, salesStore),
          //   icon: Icon(Icons.search_outlined),
          // ),
        ],
      ),
      drawer: const DrawerAdmin(),
      body: Observer(
        builder: (context) {
          return ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return null;
            },
          );
        },
      ),
    );
  }
}
