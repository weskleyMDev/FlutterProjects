import 'package:flutter/material.dart';

import '../components/calculate_button.dart';
import '../components/input_data.dart';
import '../components/profile_image.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.refresh_sharp)),
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
                  const ProfileImage(),
                  const SizedBox(height: 10.0),
                  const InputData(),
                  const SizedBox(height: 10.0),
                  const CalculateButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
