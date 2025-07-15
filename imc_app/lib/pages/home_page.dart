import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/form_data.dart';
import '../components/profile_data.dart';
import '../components/result_label.dart';
import '../providers/fields.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<FieldsProvider>(
                context,
                listen: false,
              ).clearAll(context);
            },
            icon: Icon(Icons.refresh_sharp),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ProfileData(),
                  const SizedBox(height: 30.0),
                  const FormData(),
                  const SizedBox(height: 10.0),
                  const ResultLabel(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
