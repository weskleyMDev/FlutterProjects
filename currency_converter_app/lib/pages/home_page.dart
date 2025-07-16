import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ApiService>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page'), centerTitle: true),
      body: FutureBuilder<Map>(
        future: provider.loadData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return const Center(child: Text('Error loading data!'));
              } else {
                return Observer(
                  builder: (context) {
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
                                    controller: provider.realController,
                                    onChanged: provider.realChanged,
                                  ),
                                  _buildTextField(
                                    label: 'DOLLAR',
                                    prefixText: '\$ ',
                                    controller: provider.dollarController,
                                    onChanged: provider.dollarChanged,
                                  ),
                                  _buildTextField(
                                    label: 'EURO',
                                    prefixText: '€ ',
                                    controller: provider.euroController,
                                    onChanged: provider.euroChanged,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
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
