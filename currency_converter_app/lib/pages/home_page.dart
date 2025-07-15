import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String url = dotenv.get('base_url');
    final String key = dotenv.get('api_key');
    final Uri uri = Uri.https(url, '/finance', {
      'format': 'json-cors',
      'key': key,
    });

    Future<Map> loadData() async {
      final Response response = await get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: FutureBuilder<Map>(
        future: loadData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return const Center(child: Text('Error loading data!'));
              } else {
                // final Map<String, dynamic> reais =
                //     snapshot.data?['results']['currencies']['BRL'];
                // final Map<String, dynamic> dollar =
                //     snapshot.data?['results']['currencies']['USD'];
                // final Map<String, dynamic> euro =
                //     snapshot.data?['results']['currencies']['EUR'];
                return LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  //print(await loadData());
                                },
                                child: Text('load'),
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'REAIS',
                                  prefixText: 'R\$ ',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              Divider(color: Colors.transparent),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'DOLLAR',
                                  prefixText: 'US\$ ',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              Divider(color: Colors.transparent),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'EUROS',
                                  prefixText: '€\$ ',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
          }
        },
      ),
    );
  }
}
