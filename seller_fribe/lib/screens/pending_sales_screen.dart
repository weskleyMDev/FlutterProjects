import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:seller_fribe/blocs/auth/auth_bloc.dart';
import 'package:seller_fribe/blocs/pending_sales/pending_sales_bloc.dart';
import 'package:seller_fribe/blocs/pending_sales/pending_sales_state.dart';
import 'package:seller_fribe/blocs/products/product_bloc.dart';
import 'package:seller_fribe/models/product_model.dart';
import 'package:seller_fribe/repositories/pending_sales/pending_sale_repository.dart';
import 'package:seller_fribe/utils/capitalize_text.dart';
import 'package:seller_fribe/widgets/user_drawer.dart';

class PendingSalesScreen extends StatefulWidget {
  const PendingSalesScreen({super.key});

  @override
  State<PendingSalesScreen> createState() => _PendingSalesScreenState();
}

class _PendingSalesScreenState extends State<PendingSalesScreen> {
  late final AuthBloc _authBloc;
  final IPendingSaleRepository pendingSaleRepository = PendingSaleRepository();

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('VALES'), centerTitle: true),
      drawer: UserDrawer(authBloc: _authBloc),
      body: BlocBuilder<PendingSalesBloc, PendingSalesState>(
        builder: (context, state) {
          if (state.status == PendingSalesStatus.success) {
            final pendingSales = state.pendingSales;
            if (pendingSales.isEmpty) {
              return const Center(
                child: Text(
                  'Nenhum vale encontrado!',
                  style: TextStyle(fontSize: 16),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: pendingSales.length,
                itemBuilder: (context, index) {
                  final sale = pendingSales[index];
                  final locale = Localizations.localeOf(context).languageCode;
                  final currency = NumberFormat.simpleCurrency(locale: locale);
                  return ExpansionTile(
                    title: Text(
                      sale.id.replaceAll('_', ' ').capitalize(),
                      style: const TextStyle(fontSize: 22),
                    ),
                    children: sale.receipts.map((receipt) {
                      final paymentStatus = receipt.status
                          ? 'Pago'
                          : 'Pendente';
                      final date = DateFormat.yMEd(
                        locale,
                      ).add_Hm().format(receipt.createAt ?? DateTime.now());
                      return ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SelectableText(receipt.id),
                            Text(
                              paymentStatus,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(date.capitalize()),
                            if (receipt.discount.isNotEmpty)
                              Text('Desconto: ${receipt.discount}'),
                            Text(
                              'Total: ${currency.format(double.parse(receipt.total))}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ...receipt.cart.map(
                              (e) =>
                                  BlocSelector<
                                    ProductBloc,
                                    ProductState,
                                    ProductModel
                                  >(
                                    selector: (state) {
                                      return state.allProducts.firstWhere(
                                        (product) =>
                                            product.id ==
                                            receipt.cart.first.productId,
                                      );
                                    },
                                    builder: (context, product) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '   ${product.name.capitalize()}  x${e.quantity.toStringAsFixed(3)}',
                                          ),
                                          Text(currency.format(e.subtotal)),
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
          }
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 20),
                Text('Cargando...', style: const TextStyle(fontSize: 16)),
              ],
            ),
          );
        },
      ),
    );
  }
}
