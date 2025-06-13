import 'package:flutter/material.dart';

import '../utils/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Meus Lugares Favoritos')),
      body: Center(child: CircularProgressIndicator()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.placeForm);
        },
        child: Icon(Icons.add_sharp),
      ),
    );
  }
}
