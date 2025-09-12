import 'package:admin_fribe/blocs/sales_receipt/sales_receipt_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SalesReceiptBloc, SalesReceiptState>(
        builder: (context, state) {
          if (state.salesStatus == SalesReceiptStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.salesStatus == SalesReceiptStatus.failure) {
            return Center(child: Text('Error: ${state.salesErrorMessage}'));
          } else if (state.salesStatus == SalesReceiptStatus.success) {
            return ListView.builder(
              itemCount: state.salesReceipts.length,
              itemBuilder: (context, index) {
                final receipt = state.salesReceipts[index];
                final locale = Localizations.localeOf(context).languageCode;
                final date = DateFormat.yMd(
                  locale,
                ).add_Hm().format(receipt.createAt);
                return ListTile(
                  title: Text('ID: ${receipt.id}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Amount: \$${receipt.total}'),
                      Text('Date: $date'),
                    ],
                  ),
                );
              },
            );
          }
          return const Center(child: Text('Please wait...'));
        },
      ),
    );
  }
}
