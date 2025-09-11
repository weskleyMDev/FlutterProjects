import 'package:admin_fribe/repositories/sales_receipt/isales_receipt_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<ISalesReceiptRepository>(context);
    return Scaffold(
      body: StreamBuilder(
        stream: repository.getSalesReceiptsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final salesReceipts = snapshot.data!;
            return ListView.builder(
              itemCount: salesReceipts.length,
              itemBuilder: (context, index) {
                final receipt = salesReceipts[index];
                return ListTile(
                  title: Text('ID: ${receipt.id}'),
                  subtitle: Text('Amount: \$${receipt.total}'),
                );
              },
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
