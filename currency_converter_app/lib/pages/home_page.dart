import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController realController = TextEditingController();
  final TextEditingController dollarController = TextEditingController();
  final TextEditingController euroController = TextEditingController();

  double dollar = 0.0;
  double euro = 0.0;

  void realChanged(String real) {
    final realDecimal = double.tryParse(real) ?? 0.0;
    dollarController.text = (realDecimal / dollar).toStringAsFixed(2);
    euroController.text = (realDecimal / euro).toStringAsFixed(2);
  }

  void dollarChanged(String dollar) {
    final dollarDecimal = double.tryParse(dollar) ?? 0.0;
    realController.text = (dollarDecimal * this.dollar).toStringAsFixed(2);
    euroController.text = (dollarDecimal * this.dollar / euro).toStringAsFixed(
      2,
    );
  }

  void euroChanged(String euro) {
    final euroDecimal = double.tryParse(euro) ?? 0.0;
    realController.text = (euroDecimal * this.euro).toStringAsFixed(2);
    dollarController.text = (euroDecimal * this.euro / dollar).toStringAsFixed(
      2,
    );
  }

  Future<Map> loadData() async {
    final String url = dotenv.get('base_url');
    final String key = dotenv.get('api_key');
    final Uri uri = Uri.https(url, '/finance', {
      'format': 'json-cors',
      'key': key,
    });
    final Response response = await get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    final Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  double getCurrency(String currencyKey, Map<dynamic, dynamic> data) =>
      data.isNotEmpty ? data['results']['currencies'][currencyKey]['buy'] : 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page'), centerTitle: true),
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
                final data = snapshot.data ?? {};
                dollar = getCurrency('USD', data);
                euro = getCurrency('EUR', data);
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
                              SvgPicture.asset(
                                'assets/images/currency-exchange.svg',
                                width: 200,
                                height: 200,
                              ),
                              const SizedBox(height: 24.0),
                              _buildTextField(
                                label: 'REAL',
                                prefixText: 'R\$ ',
                                controller: realController,
                                onChanged: realChanged,
                              ),
                              _buildTextField(
                                label: 'DOLLAR',
                                prefixText: '\$ ',
                                controller: dollarController,
                                onChanged: dollarChanged,
                              ),
                              _buildTextField(
                                label: 'EURO',
                                prefixText: '€ ',
                                controller: euroController,
                                onChanged: euroChanged,
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

Widget _buildTextField({
  required String label,
  required String prefixText,
  required TextEditingController controller,
  required void Function(String) onChanged,
}) => Container(
  margin: const EdgeInsets.only(bottom: 12.0),
  child: TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      prefixText: prefixText,
      border: OutlineInputBorder(),
    ),
    keyboardType: TextInputType.numberWithOptions(decimal: true),
    onChanged: onChanged,
  ),
);
