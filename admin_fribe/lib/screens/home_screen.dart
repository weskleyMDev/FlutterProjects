import 'package:admin_fribe/cubits/home_tab/home_tab_cubit.dart';
import 'package:admin_fribe/screens/receipts_screen.dart';
import 'package:admin_fribe/screens/report_screen.dart';
import 'package:admin_fribe/screens/vouchers_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeTabCubit>(context);
    return Scaffold(
      body: BlocBuilder<HomeTabCubit, HomeTabState>(
        builder: (context, state) {
          return IndexedStack(
            index: homeCubit.state.tab.index,
            children: const [
              ReportScreen(),
              ReceiptsScreen(),
              VouchersScreen(),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(FontAwesome5.clipboard_list),
              onPressed: () => homeCubit.setTab(HomeTabs.report),
              tooltip: 'Relatórios',
            ),
            IconButton(
              icon: const Icon(FontAwesome5.receipt),
              onPressed: () => homeCubit.setTab(HomeTabs.sales),
              tooltip: 'Vendas',
            ),
            IconButton(
              icon: const Icon(FontAwesome5.money_check_alt),
              onPressed: () => homeCubit.setTab(HomeTabs.vouchers),
              tooltip: 'Vales',
            ),
          ],
        ),
      ),
    );
  }
}
