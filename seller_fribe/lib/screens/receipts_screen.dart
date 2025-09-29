import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:seller_fribe/blocs/auth/auth_bloc.dart';
import 'package:seller_fribe/blocs/receipts/receipt_bloc.dart';
import 'package:seller_fribe/widgets/receipt_tile.dart';
import 'package:seller_fribe/widgets/user_drawer.dart';

class ReceiptsScreen extends StatefulWidget {
  const ReceiptsScreen({super.key});

  @override
  State<ReceiptsScreen> createState() => _ReceiptsScreenState();
}

class _ReceiptsScreenState extends State<ReceiptsScreen> {
  late final AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final currency = NumberFormat.simpleCurrency(locale: locale);
    return Scaffold(
      appBar: AppBar(title: const Text('RECIBOS'), centerTitle: true),
      drawer: UserDrawer(authBloc: _authBloc),
      body: BlocBuilder<ReceiptBloc, ReceiptState>(
        builder: (context, state) {
          if (state.status == ReceiptStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == ReceiptStatus.failure) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else {
            final grouped = groupBy(
              state.receipts,
              (receipt) => DateFormat.yMd(
                locale,
              ).format(receipt.createAt ?? DateTime.now()),
            );
            final dateKeys = grouped.keys.toList()
              ..sort((a, b) => b.compareTo(a));
            final receipts = <Widget>[];
            for (final date in dateKeys) {
              final receiptOfDay = grouped[date]!;
              final totalOfDay = receiptOfDay
                  .fold<Decimal>(
                    Decimal.zero,
                    (previousValue, element) =>
                        previousValue + Decimal.parse(element.total),
                  )
                  .round(scale: 2);
              receipts.add(
                Card(
                  child: ExpansionTile(
                    title: Text(
                      '$date - Total: ${currency.format(totalOfDay.toDouble())}',
                    ),
                    children: receiptOfDay
                        .map(
                          (receipt) => ReceiptTile(
                            currency: currency,
                            receipt: receipt,
                            locale: locale,
                          ),
                        )
                        .toList(),
                  ),
                ),
              );
            }
            return ListView(shrinkWrap: true, children: receipts);
          }
        },
      ),
    );
  }
}
