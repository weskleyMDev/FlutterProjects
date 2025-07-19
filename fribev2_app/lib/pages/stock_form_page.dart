import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/stock_form.dart';
import '../models/form_data/stock_form_data.dart';
import '../stores/stock.store.dart';

class StockFormPage extends StatefulWidget {
  const StockFormPage({super.key});

  @override
  State<StockFormPage> createState() => _StockFormPageState();
}

class _StockFormPageState extends State<StockFormPage> {
  bool _isLoading = false;
  void _handleStockData(StockFormData formData) {
    final stockStore = Provider.of<StockStore>(context, listen: false);
    try {
      setState(() => _isLoading = true);
      stockStore.addToStock(product: formData);
    } catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error adding to stock: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar ao estoque'),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: StockForm(onSubmit: _handleStockData),
                ),
              ),
              if (_isLoading)
                Container(
                  color: Colors.black54,
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
    );
  }
}
