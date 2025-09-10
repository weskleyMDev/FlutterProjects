import 'package:flutter/material.dart';
import 'package:fribev2_app/generated/l10n.dart';
import 'package:fribev2_app/stores/cart.store.dart';
import 'package:fribev2_app/stores/payment.store.dart';
import 'package:go_router/go_router.dart';

void paymentMethod(
  BuildContext context,
  PaymentStore paymentStore,
  CartStore cartStore,
  GlobalKey<FormState> formKey,
) {
  showDialog(
    context: context,
    builder: (_) {
      final paymentType = paymentStore.paymentType;
      return AlertDialog(
        title: Text('Forma de Pagamento'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField(
                key: const ValueKey('payment_method'),
                decoration: InputDecoration(
                  labelText: 'Forma de Pagamento',
                  border: OutlineInputBorder(),
                ),
                initialValue: paymentType,
                items: PaymentTypes.values
                    .map(
                      (payment) => DropdownMenuItem<PaymentTypes>(
                        value: payment,
                        child: Text(payment.type),
                      ),
                    )
                    .toList(),
                onChanged: (newValue) {
                  if (newValue != null) {
                    paymentStore.setPaymentType(newValue);
                  }
                },
                validator: (value) {
                  if (value == null) {
                    return 'Selecione uma categoria válida';
                  }
                  return null;
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  key: const ValueKey('payment_value'),
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Valor',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (newValue) => paymentStore.setPaymentValue(
                    newValue?.trim().replaceAll(',', '.') ?? '0',
                  ),
                  validator: (value) {
                    final text = value?.trim() ?? '';
                    if (text.isEmpty) {
                      return S.of(context).required_field;
                    }
                    final decimalValid = RegExp(
                      r'^(?!0(\,0+)?$)(?!0\d)(\d+([\.,]\d{1,2})?)$',
                    ).hasMatch(text);
                    if (!decimalValid) {
                      return S.of(context).invalid_value;
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () async {
              final isValid = formKey.currentState?.validate() ?? false;
              if (!isValid) return;
              formKey.currentState?.save();
              final remaining = cartStore.remaining;
              if (double.parse(paymentStore.paymentValue) > remaining) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Valor excede o total do carrinho!')),
                );
                return;
              }
              await paymentStore.pay();
              paymentStore.clearPaymentFields();
              formKey.currentState?.reset();
              if (!context.mounted) return;
              cartStore.setRemaining(context);
              context.pop();
            },
            child: Text(S.of(context).confirm),
          ),
        ],
      );
    },
  );
}
