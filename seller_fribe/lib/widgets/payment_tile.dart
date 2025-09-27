import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seller_fribe/blocs/cart/cart_bloc.dart';
import 'package:seller_fribe/utils/capitalize_text.dart';

class PaymentTile extends StatelessWidget {
  const PaymentTile({
    super.key,
    required this.currency,
    required this.state,
    required this.openPaymentDialog,
  });

  final NumberFormat currency;
  final CartState state;
  final VoidCallback openPaymentDialog;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pagamentos:',
                style: TextStyle(fontSize: 18.0),
              ),
              IconButton(
                onPressed: openPaymentDialog,
                icon: const Icon(Icons.add_circle),
              ),
            ],
          ),
          if (state.payments.isEmpty)
            const Text('Nenhum pagamento adicionado')
          else
            Column(
              children: state.payments
                  .map(
                    (payment) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${payment.method.capitalize()}: '),
                        Text(currency.format(double.tryParse(payment.amount) ?? 0.0)),
                      ],
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}