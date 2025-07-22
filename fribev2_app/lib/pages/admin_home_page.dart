import 'package:flutter/material.dart';
import 'package:fribev2_app/utils/capitalize_text.dart';
import 'package:provider/provider.dart';

import '../components/drawer_admin.dart';
import '../stores/auth.store.dart';
import '../stores/sales.store.dart';
import '../stores/sales_filter.store.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context, listen: false);
    final salesStore = Provider.of<SalesStore>(context, listen: false);
    final salesFilterStore = Provider.of<SalesFilterStore>(
      context,
      listen: false,
    );
    final name = authStore.currentUser?.email.split('@')[0] ?? 'Usuário';
    return Scaffold(
      appBar: AppBar(title: Text('Bem vindo, ${name.capitalize()}!')),
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
                    salesFilterStore.setGroupedSales(receipts);
                    return ListView.builder(
                      itemCount: salesFilterStore.sortedKeys.length,
                      itemBuilder: (context, index) {
                        final dateKey = salesFilterStore.sortedKeys[index];
                        final salesDay =
                            salesFilterStore.groupedSales[dateKey] ?? [];
                        salesFilterStore.setTotalOfDay(salesDay);
                        final totalDay = salesFilterStore.totalOfDay;
                        return ExpansionTile(
                          title: Text(
                            '$dateKey - R\$ ${totalDay.replaceAll('.', ',')}',
                          ),
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: salesDay.length,
                              itemBuilder: (context, index) {
                                final sales = salesDay[index];
                                return ListTile(
                                  title: SelectableText('Recibo: #${sales.id}'),
                                  subtitle: Text(
                                    'Total: R\$ ${sales.total.replaceAll('.', ',')}',
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
              }
            },
          );
        },
      ),
    );
  }
}
