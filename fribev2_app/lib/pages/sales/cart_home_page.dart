import 'package:flutter/material.dart';
import 'package:fribev2_app/components/cart_panel.dart';
import 'package:fribev2_app/generated/l10n.dart';
import 'package:go_router/go_router.dart';

class CartHomePage extends StatefulWidget {
  const CartHomePage({super.key});

  @override
  State<CartHomePage> createState() => _CartHomePageState();
}

class _CartHomePageState extends State<CartHomePage> {
  Future<bool?> _leaveDialog() => showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(S.of(context).cart_dialog_title),
      content: Text(S.of(context).cart_dialog_body),
      actions: [
        TextButton(
          onPressed: () => context.pop(false),
          child: Text(S.of(context).cancel),
        ),
        TextButton(
          onPressed: () => context.pop(true),
          child: Text(S.of(context).leave),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          final shouldExit = await _leaveDialog();
          if (shouldExit ?? false) {
            if (!context.mounted) return;
            context.pop();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(S.of(context).shopping_cart)),
        body: CartPanel(),
      ),
    );
  }
}
