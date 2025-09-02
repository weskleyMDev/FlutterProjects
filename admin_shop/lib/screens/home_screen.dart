import 'package:admin_shop/blocs/auth/auth_bloc.dart';
import 'package:admin_shop/generated/l10n.dart';
import 'package:admin_shop/screens/loading_screen.dart';
import 'package:admin_shop/screens/tabs/clients_tab.dart';
import 'package:admin_shop/screens/tabs/orders_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final userName = authBloc.state.user?.name ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).greeting(userName)),
        actions: [
          IconButton(
            onPressed: () => authBloc.add(SignOutRequested()),
            icon: const Icon(FontAwesome5.sign_out_alt),
            tooltip: S.of(context).logout,
          ),
        ],
        actionsPadding: const EdgeInsets.only(right: 6),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Stack(
            children: [
              PageView(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    _currentIndex = value;
                  });
                },
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ClientsTab(),
                  OrdersTab(),
                  Container(color: Colors.blue),
                ],
              ),
              (state.status == AuthStatus.waiting)
                  ? const LoadingScreen()
                  : const SizedBox.shrink(),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        unselectedItemColor: Colors.grey.shade600,
        onTap: (value) {
          _pageController.animateToPage(
            value,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(FontAwesome5.user_alt),
            label: S.of(context).clients,
          ),
          BottomNavigationBarItem(
            icon: const Icon(FontAwesome5.clipboard_list),
            label: S.of(context).orders,
          ),
          BottomNavigationBarItem(
            icon: const Icon(FontAwesome5.boxes),
            label: S.of(context).products,
          ),
        ],
      ),
    );
  }
}
