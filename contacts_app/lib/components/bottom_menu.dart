import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/contact.dart';

class BottomMenu extends StatelessWidget {
  const BottomMenu({super.key, required this.contact});

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return BottomSheet(
          onClosing: () {},
          builder: (_) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              width: constraints.maxWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 12.0,
                    ),
                    child: TextButton.icon(
                      onPressed: () {
                        launchUrl(Uri.parse('tel:1234567890'));
                      },
                      label: Text('CALL'),
                      icon: Icon(FontAwesome5.phone_alt),
                      iconAlignment: IconAlignment.end,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 12.0,
                    ),
                    child: TextButton.icon(
                      onPressed: () {
                        launchUrl(Uri.https('wa.me', '/${contact.phone}'));
                      },
                      label: Text('MESSAGE'),
                      icon: Icon(FontAwesome5.whatsapp),
                      iconAlignment: IconAlignment.end,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
