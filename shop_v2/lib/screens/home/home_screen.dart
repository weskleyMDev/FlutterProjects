import 'package:flutter/material.dart';
import 'package:shop_v2/components/home/home_drawer.dart';
import 'package:shop_v2/components/home/home_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return PageView(
      controller: pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [Scaffold(drawer: HomeDrawer(), body: HomeTab())],
    );
  }
}
