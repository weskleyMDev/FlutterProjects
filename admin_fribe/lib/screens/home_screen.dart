import 'package:admin_fribe/blocs/auth/auth_bloc.dart';
import 'package:admin_fribe/cubits/home_tab/home_tab_cubit.dart';
import 'package:admin_fribe/screens/products_screen.dart';
import 'package:admin_fribe/screens/receipts_screen.dart';
import 'package:admin_fribe/screens/report_screen.dart';
import 'package:admin_fribe/screens/vouchers_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeTabCubit>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    TextButton navButton(HomeTabs tab, String label, IconData icon) {
      final isSelected = homeCubit.state.tab == tab;
      final color = isSelected
          ? Theme.of(context).colorScheme.primary
          : Colors.grey.shade600;
      return TextButton(
        style: TextButton.styleFrom(overlayColor: Colors.transparent),
        onPressed: () => homeCubit.setTab(tab),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            Text(label, style: TextStyle(color: color)),
          ],
        ),
      );
    }

    return BlocBuilder<HomeTabCubit, HomeTabState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Admin Fribe'),
            actions: [
              IconButton(
                icon: const Icon(FontAwesome5.plus),
                tooltip: 'Add Product',
                onPressed: () => GoRouter.of(context).pushNamed('new-product'),
              ),
              IconButton(
                icon: const Icon(FontAwesome5.sign_out_alt),
                tooltip: 'Logout',
                onPressed: () {
                  authBloc.add(const AuthLogoutRequested());
                },
              ),
            ],
          ),
          body: IndexedStack(
            index: homeCubit.state.tab.index,
            children: const [
              ReportScreen(),
              ReceiptsScreen(),
              VouchersScreen(),
              ProductsScreen(),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                navButton(
                  HomeTabs.report,
                  'Relatórios',
                  FontAwesome5.clipboard_list,
                ),
                navButton(HomeTabs.sales, 'Vendas', FontAwesome5.receipt),
                navButton(
                  HomeTabs.vouchers,
                  'Vales',
                  FontAwesome5.money_check_alt,
                ),
                navButton(HomeTabs.products, 'Produtos', FontAwesome5.boxes),
              ],
            ),
          ),
        );
      },
    );
  }
}
