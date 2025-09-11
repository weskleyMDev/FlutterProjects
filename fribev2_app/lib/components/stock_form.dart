import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

import '../models/form_data/stock_form_data.dart';
import '../models/product.dart';

const List<String> _categories = [
  '',
  'BOVINO',
  'SUINO',
  'OVINO',
  'AVES',
  'OUTROS',
];
const List<String> _measures = ['', 'KG', 'PC', 'UN'];

class StockForm extends StatefulWidget {
  const StockForm({super.key, this.onSubmit, this.product});

  final Future<void> Function(StockFormData)? onSubmit;
  final Product? product;

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
  void initState() {
    super.initState();
    if (widget.product != null) {
      final product = widget.product!;

      _formData.name = product.name;
      _formData.category = product.category;
      _formData.measure = product.measure;
      _formData.amount = product.amount;
      _formData.price = product.price;

      _nameController.text = product.name;
      _amountController.text = product.amount;
      _priceController.text = product.price;

      _selectedCategory = product.category;
      _selectedMeasure = product.measure;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _clearFields() {
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

  Future<void> _submitForm() async {
    try {
      FocusScope.of(context).unfocus();
      final bool isValid = _formKey.currentState?.validate() ?? false;
      if (!isValid) return;
      _formData.name = _nameController.text.trim().toUpperCase();
      _formData.amount = _amountController.text.trim().replaceAll(',', '.');
      _formData.price = _priceController.text.trim().replaceAll(',', '.');
      _formData.category = _selectedCategory.trim().toUpperCase();
      _formData.measure = _selectedMeasure.trim().toUpperCase();
      if (widget.onSubmit != null) {
        await widget.onSubmit!(_formData);
      }
      _formKey.currentState?.reset();
      _clearFields();
      _showSnackbar(
        widget.product == null
            ? 'Produto salvo com sucesso!'
            : 'Produto atualizado com sucesso!',
      );
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
                    final valid = RegExp(r'^[a-zA-Z0-9\s/]*$').hasMatch(name);
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
                  prefix: FontAwesome5.dollar_sign,
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
                    initialValue: _selectedMeasure.isNotEmpty
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
                  initialValue: _selectedCategory.isNotEmpty
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
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(widget.product == null ? 'SALVAR' : 'ATUALIZAR'),
                ),
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
