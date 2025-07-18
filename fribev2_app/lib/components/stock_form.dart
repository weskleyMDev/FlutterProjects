import 'package:flutter/material.dart';

import '../models/form_data/stock_form_data.dart';

class StockForm extends StatefulWidget {
  const StockForm({super.key, required this.onSubmit});

  final void Function(StockFormData) onSubmit;

  @override
  State<StockForm> createState() => _StockFormState();
}

class _StockFormState extends State<StockForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final StockFormData _formData = StockFormData();

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  void _submitForm() {
    try {
      final bool isValid = _formKey.currentState?.validate() ?? false;
      if (!isValid) throw Exception('Fill in all the fields of the form!');
      widget.onSubmit(_formData);
    } catch (e) {
      _showSnackbar(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12.0),
      child: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 12.0),
                child: TextFormField(
                  key: const ValueKey('product'),
                  initialValue: _formData.name,
                  onChanged: (value) => _formData.name = value,
                  decoration: const InputDecoration(
                    labelText: 'Produto',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.mail_outline_sharp),
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12.0),
                child: TextFormField(
                  key: const ValueKey('amount'),
                  initialValue: _formData.amount,
                  onChanged: (value) => _formData.amount = value,
                  decoration: const InputDecoration(
                    labelText: 'Quantidade',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.mail_outline_sharp),
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 22.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('SALVAR'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}