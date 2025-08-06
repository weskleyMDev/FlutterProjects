import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:shop_v2/l10n/app_localizations.dart';
import 'package:shop_v2/utils/theme/gradient.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          buildBodyBack(
            colorX: Colors.blueGrey.shade700,
            colorY: Colors.grey.shade100,
            x: Alignment.topCenter,
            y: Alignment.bottomCenter,
          ),
          Column(
            children: [
              DrawerHeader(
                child: SizedBox(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.shop_clothings_v2,
                        style: TextStyle(fontSize: 28.0),
                      ),
                      Positioned(
                        bottom: 0.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${AppLocalizations.of(context)!.hello},'),
                            InkWell(
                              onTap: () {},
                              child: Text.rich(
                                TextSpan(
                                  text:
                                      '${AppLocalizations.of(context)!.already_have_an_account}? ',
                                  children: [
                                    TextSpan(
                                      text:
                                          '${AppLocalizations.of(context)!.sign_in}.',
                                      style: TextStyle(
                                        color: Colors.deepPurple.shade700,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(FontAwesome5.home),
                title: Text(AppLocalizations.of(context)!.home),
                titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
                iconColor: Colors.deepPurple.shade700,
                textColor: Colors.deepPurple.shade700,
                onTap: () {},
              ),
              ListTile(
                leading: Icon(FontAwesome5.id_card),
                title: Text(AppLocalizations.of(context)!.profile),
                titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
                iconColor: Colors.deepPurple.shade700,
                textColor: Colors.deepPurple.shade700,
                onTap: () {},
              ),
              ListTile(
                leading: Icon(FontAwesome5.tshirt),
                title: Text(AppLocalizations.of(context)!.product(2)),
                titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
                iconColor: Colors.deepPurple.shade700,
                textColor: Colors.deepPurple.shade700,
                onTap: () {},
              ),
              ListTile(
                leading: Icon(FontAwesome5.truck),
                title: Text(AppLocalizations.of(context)!.orders),
                titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
                iconColor: Colors.deepPurple.shade700,
                textColor: Colors.deepPurple.shade700,
                onTap: () {},
              ),
              Spacer(),
              ListTile(
                leading: Icon(FontAwesome5.sign_out_alt),
                title: Text(AppLocalizations.of(context)!.sign_out),
                titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
                iconColor: Colors.red.shade700,
                textColor: Colors.red.shade700,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
