import 'package:flutter/material.dart';
import 'package:shop_v2/components/forms/new_acc_form.dart';
import 'package:shop_v2/l10n/app_localizations.dart';

class NewAccScreen extends StatelessWidget {
  const NewAccScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.new_account),
      ),
      body: NewAccForm(),
    );
  }
}
