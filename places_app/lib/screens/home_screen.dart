import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/places_provider.dart';
import '../utils/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Meus Lugares Favoritos')),
      body: Consumer<PlacesProvider>(
        child: Center(child: Text('Nenhum Lugar Favorito!')),
        builder: (ctx, provider, child) => provider.itemsCount == 0
            ? child!
            : ListView.builder(
                itemCount: provider.places.length,
                itemBuilder: (ctx, i) {
                  final place = provider.places[i];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: FileImage(place.image),
                    ),
                    title: Text(place.title),
                  );
                },
              ),
      ),
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
