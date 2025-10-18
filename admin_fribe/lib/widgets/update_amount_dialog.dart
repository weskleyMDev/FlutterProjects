import 'package:admin_fribe/blocs/update_amount/update_amount_bloc.dart';
import 'package:admin_fribe/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class UpdateAmountDialog extends StatelessWidget {
  const UpdateAmountDialog({
    super.key,
    required this.product,
    required this.dialogContext,
  });

  final ProductModel product;
  final BuildContext dialogContext;

  @override
  Widget build(BuildContext context) {
    void safePop(BuildContext context) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      });
    }

    return BlocConsumer<UpdateAmountBloc, UpdateAmountState>(
      listener: (context, state) {
        if (state.submissionStatus == FormzSubmissionStatus.success) {
          safePop(dialogContext);
          BlocProvider.of<UpdateAmountBloc>(context).add(ClearAmountInput());
        } else if (state.submissionStatus == FormzSubmissionStatus.failure) {
          final errorMessage =
              state.errorMessage ?? 'An unknown error occurred';
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(SnackBar(content: Text(errorMessage)));
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            AlertDialog(
              title: Text(product.name),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    key: const ValueKey('updateAmountTextField'),
                    decoration: InputDecoration(
                      labelText: 'New Amount',
                      border: const OutlineInputBorder(),
                      errorText: state.amountErrorText,
                    ),
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onChanged: (value) =>
                        BlocProvider.of<UpdateAmountBloc>(context).add(
                          AmountInputChanged(value.trim().replaceAll(',', '.')),
                        ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    safePop(dialogContext);
                    BlocProvider.of<UpdateAmountBloc>(
                      context,
                    ).add(ClearAmountInput());
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: state.isValid
                      ? () => BlocProvider.of<UpdateAmountBloc>(
                          context,
                        ).add(UpdateAmountSubmitted(product.id))
                      : null,
                  child: const Text('Update'),
                ),
              ],
            ),
            if (state.submissionStatus == FormzSubmissionStatus.inProgress)
              const Positioned.fill(
                child: ColoredBox(
                  color: Colors.black26,
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
          ],
        );
      },
    );
  }
}
