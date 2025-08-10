import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:shop_v2/components/home/home_drawer.dart';
import 'package:shop_v2/components/home/home_tab.dart';
import 'package:shop_v2/screens/loading_screen.dart';
import 'package:shop_v2/stores/auth/auth.store.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final authStore = GetIt.instance<AuthStore>();

  @override
  void initState() {
    super.initState();
    authStore.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(),
      body: Observer(
        builder: (_) {
          final status = authStore.userChanges.status;
          switch (status) {
            case StreamStatus.waiting:
              return const LoadingScreen();
            default:
                return HomeTab();
          }
        },
      ),
    );
  }
}
