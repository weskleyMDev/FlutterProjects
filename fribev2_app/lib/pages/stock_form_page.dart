import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../components/stock_form.dart';
import '../models/form_data/stock_form_data.dart';
import '../models/product.dart';
import '../stores/stock.store.dart';

class StockFormPage extends StatefulWidget {
  const StockFormPage({super.key, this.product});

  final Product? product;

  @override
  State<StockFormPage> createState() => _StockFormPageState();
}

class _StockFormPageState extends State<StockFormPage> {
  bool _isLoading = false;
  Future<void> _handleStockData(StockFormData formData) async {
    final stockStore = Provider.of<StockStore>(context, listen: false);
    try {
      setState(() => _isLoading = true);
      if (widget.product == null) {
        final newProduct = Product(
          id: '',
          name: formData.name,
          category: formData.category,
          price: formData.price,
          measure: formData.measure,
          amount: formData.amount,
        );
        await stockStore.addToStock(product: newProduct);
      } else {
        final updatedProduct = Product(
          id: widget.product!.id,
          name: formData.name,
          category: formData.category,
          price: formData.price,
          measure: formData.measure,
          amount: formData.amount,
        );
        await stockStore.updateProduct(product: updatedProduct);
        if (mounted) context.pop();
      }
    } catch (e) {
      if (!mounted) return;
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          widget.product == null
              ? 'Adicionar ao estoque'
              : 'Atualizar o estoque',
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: StockForm(
                    onSubmit: _handleStockData,
                    product: widget.product,
                  ),
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
