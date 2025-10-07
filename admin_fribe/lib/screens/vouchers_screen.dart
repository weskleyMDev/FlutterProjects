import 'package:admin_fribe/blocs/pending_sales/pending_sale_bloc.dart';
import 'package:admin_fribe/blocs/product/product_bloc.dart';
import 'package:admin_fribe/models/product_model.dart';
import 'package:admin_fribe/utils/capitalize_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class VouchersScreen extends StatefulWidget {
  const VouchersScreen({super.key});

  @override
  State<VouchersScreen> createState() => _VouchersScreenState();
}

class _VouchersScreenState extends State<VouchersScreen> {
  static const WidgetStateProperty<Icon> thumbIcon =
      WidgetStateProperty<Icon>.fromMap(<WidgetStatesConstraint, Icon>{
        WidgetState.selected: Icon(Icons.check),
        WidgetState.any: Icon(Icons.close),
      });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PendingSaleBloc, PendingSaleState>(
      builder: (context, state) {
        if (state.status == PendingSaleStatus.success) {
          final pendingSales = state.pendingSales;
          if (pendingSales.isEmpty) {
            return const Center(child: Text('No pending sales'));
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: pendingSales.length,
              itemBuilder: (context, index) {
                final sale = pendingSales[index];
                final locale = Localizations.localeOf(context).languageCode;
                final currency = NumberFormat.simpleCurrency(locale: locale);
                final amount = NumberFormat.decimalPatternDigits(
                  locale: locale,
                  decimalDigits: 3,
                );
                return ExpansionTile(
                  key: const ValueKey('expansion_pending_tile'),
                  initiallyExpanded: state.expandedTiles.contains(sale.id),
                  onExpansionChanged: (isExpanded) {
                    BlocProvider.of<PendingSaleBloc>(context).add(
                      ToggleExpansionEvent(
                        tileId: sale.id,
                        isExpanded: isExpanded,
                      ),
                    );
                  },
                  title: Text(sale.id.replaceAll('_', ' ').capitalize()),
                  children: sale.receipts.map((receipt) {
                    final isLoading = state.status == PendingSaleStatus.loading;
                    final date = DateFormat.yMd(
                      locale,
                    ).format(receipt.createAt);
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            receipt.id.toUpperCase(),
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          Switch(
                            thumbIcon: thumbIcon,
                            value: receipt.status,
                            onChanged: isLoading
                                ? null
                                : (value) =>
                                      BlocProvider.of<PendingSaleBloc>(
                                        context,
                                      ).add(
                                        UpdatePaymentStatusEvent(
                                          pendingSaleId: sale.id,
                                          receiptId: receipt.id,
                                          status: value,
                                        ),
                                      ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(date),
                          Text(
                            'Desconto: ${currency.format(double.tryParse(receipt.discount) ?? 0.0)}',
                          ),
                          Text(
                            'Total: ${currency.format(double.tryParse(receipt.total) ?? 0.0)}',
                          ),
                          ...receipt.cart.map<Widget>(
                            (item) =>
                                BlocSelector<
                                  ProductBloc,
                                  ProductState,
                                  ProductModel
                                >(
                                  selector: (state) {
                                    return state.products
                                        .whereType<ProductModel>()
                                        .firstWhere(
                                          (product) =>
                                              product.id == item.productId,
                                          orElse: () => ProductModel.empty(),
                                        );
                                  },
                                  builder: (context, product) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${product.name} x ${amount.format(item.quantity)}',
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                        Text(
                                          currency.format(item.subtotal),
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            );
          }
        } else if (state.status == PendingSaleStatus.failure) {
          return const Center(child: Text('Failed to load pending sales'));
        } else {
          return Container(
            color: Colors.black54,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
