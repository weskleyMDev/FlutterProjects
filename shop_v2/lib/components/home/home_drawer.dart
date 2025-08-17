import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_v2/l10n/app_localizations.dart';
import 'package:shop_v2/stores/auth/auth.store.dart';
import 'package:shop_v2/stores/components/drawer.store.dart';
import 'package:shop_v2/utils/theme/gradient.dart';

final drawerStore = GetIt.instance<DrawerStore>();
final authStore = GetIt.instance<AuthStore>();

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  Widget _drawerTile(
    BuildContext context,
    IconData icon,
    String title,
    String path,
    bool isSelected,
    DrawerOptions option,
  ) => ListTile(
    leading: Icon(icon),
    title: Text(title),
    titleTextStyle: TextStyle(
      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      fontSize: isSelected ? 18.0 : 16.0,
    ),
    iconColor: isSelected ? Colors.deepPurple.shade700 : Colors.grey.shade700,
    textColor: isSelected ? Colors.deepPurple.shade700 : Colors.grey.shade700,
    onTap: () {
      drawerStore.toggleOption(option);
      context.goNamed(path);
    },
  );

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
                    alignment: AlignmentDirectional.centerStart,
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
                            (authStore.currentUser != null)
                                ? Text(
                                    '${AppLocalizations.of(context)!.hello}, ${authStore.currentUser!.name}!',
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : InkWell(
                                    onTap: () {
                                      context.pop();
                                      context.pushNamed('login-screen');
                                    },
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
              _drawerTile(
                context,
                FontAwesome5.home,
                AppLocalizations.of(context)!.home,
                'home-screen',
                drawerStore.isHome,
                DrawerOptions.home,
              ),
              _drawerTile(
                context,
                FontAwesome5.id_card,
                AppLocalizations.of(context)!.profile,
                'profile-screen',
                drawerStore.isProfile,
                DrawerOptions.profile,
              ),
              _drawerTile(
                context,
                FontAwesome5.tshirt,
                AppLocalizations.of(context)!.product(2),
                'categories-screen',
                drawerStore.isProducts,
                DrawerOptions.products,
              ),
              _drawerTile(
                context,
                FontAwesome5.truck,
                AppLocalizations.of(context)!.orders,
                'orders-screen',
                drawerStore.isOrders,
                DrawerOptions.orders,
              ),
              Spacer(),
              if (authStore.currentUser != null)
                ListTile(
                  leading: Icon(FontAwesome5.sign_out_alt),
                  title: Text(AppLocalizations.of(context)!.sign_out),
                  titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  iconColor: Colors.red.shade700,
                  textColor: Colors.red.shade700,
                  onTap: () async {
                    await authStore.signOutUser();
                    drawerStore.toggleOption(DrawerOptions.home);
                    if (!context.mounted) return;
                    context.pop();
                    context.goNamed('home-screen');
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
