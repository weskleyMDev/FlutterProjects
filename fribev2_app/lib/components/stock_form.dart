import 'package:flutter/material.dart';

import '../models/form_data/stock_form_data.dart';

const List<String> _categories = [
  '',
  'BOVINO',
  'SUÍNO',
  'OVINO',
  'AVES',
  'OUTROS',
];
const List<String> _measures = ['', 'KG', 'PC', 'UN'];

class StockForm extends StatefulWidget {
  const StockForm({super.key, required this.onSubmit});

  final void Function(StockFormData) onSubmit;

  @override
  State<StockForm> createState() => _StockFormState();
}

class _StockFormState extends State<StockForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final StockFormData _formData = StockFormData();
  String _selectedCategory = '';
  String _selectedMeasure = '';

  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _clearFFields() {
    _nameController.clear();
    _amountController.clear();
    _priceController.clear();

    setState(() {
      _selectedCategory = '';
      _selectedMeasure = '';
      _formData.clear();
    });
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  void _submitForm() {
    try {
      FocusScope.of(context).unfocus();
      final bool isValid = _formKey.currentState?.validate() ?? false;
      if (!isValid) throw Exception('Existem erros a serem corrigidos!');
      widget.onSubmit(_formData);
      _formKey.currentState?.reset();
      _clearFFields();
      _showSnackbar('Produto salvo com sucesso!');
    } catch (e) {
      _showSnackbar(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
      child: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.all(12.0),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextFormField(
                  key: 'product',
                  label: 'Produto',
                  controller: _nameController,
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  onChanged: (value) =>
                      _formData.name = value.trim().toUpperCase(),
                  prefix: Icons.add_box_outlined,
                  validator: (value) {
                    final name = value?.trim() ?? '';
                    if (name.isEmpty) {
                      return 'Campo obrigatório!';
                    }
                    final valid = RegExp(r'^[a-zA-Z\s]*$').hasMatch(name);
                    if (!valid) {
                      return 'Utilize apenas letras sem caracteres especiais!';
                    }
                    return null;
                  },
                ),
                _buildTextFormField(
                  key: 'amount',
                  label: 'Quantidade',
                  controller: _amountController,
                  inputType: TextInputType.numberWithOptions(decimal: true),
                  inputAction: TextInputAction.next,
                  onChanged: (value) =>
                      _formData.amount = value.trim().replaceAll(',', '.'),
                  prefix: Icons.scale_outlined,
                  validator: (value) {
                    final amount = value?.trim().replaceAll(',', '.') ?? '0.00';
                    if (amount.isEmpty) {
                      return 'Campo obrigatório!';
                    }
                    final valid = RegExp(
                      r'^\d+([.,]\d{0,3})?$',
                    ).hasMatch(amount);
                    if (!valid) {
                      return 'Digite apenas números (ex: 2.459)';
                    }
                    return null;
                  },
                ),
                _buildTextFormField(
                  key: 'price',
                  label: 'Preço',
                  controller: _priceController,
                  inputType: TextInputType.numberWithOptions(decimal: true),
                  inputAction: TextInputAction.next,
                  onChanged: (value) =>
                      _formData.price = value.trim().replaceAll(',', '.'),
                  prefix: Icons.attach_money_outlined,
                  validator: (value) {
                    final price = value?.trim().replaceAll(',', '.') ?? '0.00';
                    if (price.isEmpty) {
                      return 'Campo obrigatório!';
                    }
                    final valid = RegExp(
                      r'^\d+([.,]\d{0,2})?$',
                    ).hasMatch(price);
                    if (!valid) {
                      return 'Digite apenas números (ex: 12.89)';
                    }
                    return null;
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      labelText: 'Medida',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedMeasure.isNotEmpty
                        ? _selectedMeasure
                        : null,
                    items: _measures.map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value.isEmpty ? 'Selecione uma medida' : value,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedMeasure = value ?? '';
                        _formData.measure = _selectedMeasure;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Selecione uma medida válida';
                      }
                      return null;
                    },
                  ),
                ),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: 'Categoria',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedCategory.isNotEmpty
                      ? _selectedCategory
                      : null,
                  items: _categories.map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value.isEmpty ? 'Selecione uma categoria' : value,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value ?? '';
                      _formData.category = _selectedCategory;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Selecione uma categoria válida';
                    }
                    return null;
                  },
                ),
                Spacer(),
                ElevatedButton(onPressed: _submitForm, child: Text('SALVAR')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String key,
    required String label,
    required TextInputType inputType,
    required TextInputAction inputAction,
    required ValueChanged<String> onChanged,
    required IconData prefix,
    required String? Function(String?) validator,
    required TextEditingController controller,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        key: ValueKey(key),
        controller: controller,
        onChanged: onChanged,
        textInputAction: inputAction,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          prefixIcon: Icon(prefix),
        ),
        validator: validator,
      ),
    );
  }
}
