import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:seller_fribe/blocs/cart/cart_bloc.dart';

class PaymentDialog extends StatefulWidget {
  const PaymentDialog({super.key, required this.cartBloc});

  final CartBloc cartBloc;

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if (state.submissionStatus == FormzSubmissionStatus.success) {
          Navigator.of(context).pop();
          widget.cartBloc.add(const ClearPaymentMethod());
        } else if (state.submissionStatus == FormzSubmissionStatus.failure) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Erro desconhecido'),
              ),
            );
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title: const Text('Pagamentos'),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField(
                  initialValue: state.selectedPaymentMethod,
                  items: PaymentsMethod.values
                      .map(
                        (method) => DropdownMenuItem(
                          value: method,
                          child: Text(method.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      widget.cartBloc.add(OnPaymentMethodChanged(value));
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: TextField(
                    autofocus: true,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Valor',
                      prefixText: 'R\$ ',
                      border: const OutlineInputBorder(),
                      errorText: state.paymentError,
                    ),
                    onChanged: (value) {
                      widget.cartBloc.add(
                        PaymentInputChanged(value.trim().replaceAll(',', '.')),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                GoRouter.of(context).pop();
                widget.cartBloc.add(const ClearPaymentMethod());
              },
              child: const Text('Fechar'),
            ),
            ElevatedButton(
              onPressed: state.isPaymentValid
                  ? () {
                      final method = state.selectedPaymentMethod.name;
                      final amount = state.paymentInput.value;
                      if (amount.isNotEmpty) {
                        widget.cartBloc.add(
                          SavePaymentMethod(method: method, amount: amount),
                        );
                      }
                    }
                  : null,
              child:
                  (state.submissionStatus == FormzSubmissionStatus.inProgress)
                  ? const SizedBox(
                      width: 16.0,
                      height: 16.0,
                      child: CircularProgressIndicator(strokeWidth: 2.0),
                    )
                  : const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }
}
