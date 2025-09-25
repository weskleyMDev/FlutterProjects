import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:seller_fribe/blocs/cart/cart_bloc.dart';
import 'package:seller_fribe/models/product_model.dart';

class QuantityDialog extends StatefulWidget {
  const QuantityDialog({
    super.key,
    required this.cartBloc,
    required this.product,
  });

  final CartBloc cartBloc;
  final ProductModel product;

  @override
  State<QuantityDialog> createState() => _QuantityDialogState();
}

class _QuantityDialogState extends State<QuantityDialog> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if (state.submissionStatus == FormzSubmissionStatus.success) {
          GoRouter.of(context).pop();
          print(state.cartItems);
          widget.cartBloc.add(const ClearQuantityInput());
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
          title: Text(widget.product.name),
          content: TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: 'Quantidade',
              border: OutlineInputBorder(),
              errorText: state.quantityError,
            ),
            onChanged: (value) {
              widget.cartBloc.add(
                CartProductQuantityChanged(value.trim().replaceAll(',', '.')),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                widget.cartBloc.add(const ClearQuantityInput());
                GoRouter.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: state.isValid
                  ? () {
                      widget.cartBloc.add(SaveCartItem(widget.product));
                    }
                  : null,
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }
}
