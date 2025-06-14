import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/places_provider.dart';
import '../utils/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Meus Lugares Favoritos')),
      body: FutureBuilder(
        future: Provider.of<PlacesProvider>(
          context,
          listen: false,
        ).loadPlaces(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<PlacesProvider>(
                child: Center(child: Text('Nenhum Lugar Favorito!')),
                builder: (ctx, provider, child) => provider.itemsCount == 0
                    ? child!
                    : ListView.builder(
                        itemCount: provider.itemsCount,
                        itemBuilder: (ctx, i) {
                          final place = provider.places[i];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  File(place.image!.path).existsSync()
                                  ? FileImage(place.image!)
                                  : AssetImage('assets/images/android.png')
                                        as ImageProvider,
                            ),
                            title: Text(place.title),
                          );
                        },
                      ),
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
