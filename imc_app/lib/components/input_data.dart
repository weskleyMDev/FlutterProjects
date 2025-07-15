import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/calculate.dart';

class InputData extends StatefulWidget {
  const InputData({super.key});

  @override
  State<InputData> createState() => _InputDataState();
}

class _InputDataState extends State<InputData> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _weightFocus = FocusNode();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final Map<String, dynamic> _formData = {};

  @override
  void dispose() {
    super.dispose();
    _weightFocus.dispose();
    _heightController.dispose();
    _weightController.dispose();
  }

  Future<void> _submitForm() async {
    final bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    _formKey.currentState?.save();
    final Map<String, dynamic> data = {
      'height': _formData['height'],
      'weight': _formData['weight'],
    };
    Provider.of<CalculateProvider>(
      context,
      listen: false,
    ).calculateBMI(data: data);
    _heightController.clear();
    _weightController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Height',
              border: OutlineInputBorder(),
            ),
            controller: _heightController,
            textInputAction: TextInputAction.next,
            onSaved: (height) => _formData['height'] =
                double.tryParse(height?.trim().replaceAll(',', '.') ?? '0.0') ??
                0.0,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(_weightFocus),
            validator: (value) {
              final height = value?.trim() ?? '';
              if (height.isEmpty) {
                return 'Please enter your height';
              }
              final format = RegExp(r'^\d+([.,]\d{1,2})?$').hasMatch(height);
              if (!format) {
                return 'Please enter a valid height (e.g. 1.50)';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            focusNode: _weightFocus,
            decoration: InputDecoration(
              labelText: 'Weight',
              border: OutlineInputBorder(),
            ),
            controller: _weightController,
            textInputAction: TextInputAction.done,
            onSaved: (weight) => _formData['weight'] =
                double.tryParse(weight?.trim().replaceAll(',', '.') ?? '0.0') ??
                0.0,
            onFieldSubmitted: (_) => _submitForm(),
            validator: (value) {
              final weight = value?.trim() ?? '';
              if (weight.isEmpty) {
                return 'Please enter your weight';
              }
              final format = RegExp(r'^\d+([.,]\d{1,2})?$').hasMatch(weight);
              if (!format) {
                return 'Please enter a valid weight (e.g. 70.50)';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _submitForm,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'CALCULATE',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
