import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:shop_v2/l10n/app_localizations.dart';

class NewAccForm extends StatefulWidget {
  const NewAccForm({super.key});

  @override
  State<NewAccForm> createState() => _NewAccFormState();
}

class _NewAccFormState extends State<NewAccForm> {
  final _registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registerFormKey,
      child: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                label: Text(AppLocalizations.of(context)!.select_image),
                icon: Icon(FontAwesome5.camera_retro),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: TextFormField(
              decoration: InputDecoration(
                label: Text(AppLocalizations.of(context)!.user_name),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: TextFormField(
              decoration: InputDecoration(
                label: Text(AppLocalizations.of(context)!.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: TextFormField(
              decoration: InputDecoration(
                label: Text(AppLocalizations.of(context)!.password),
              ),
              obscureText: true,
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            child: Text(AppLocalizations.of(context)!.sign_up.toUpperCase()),
          ),
        ],
      ),
    );
  }
}
