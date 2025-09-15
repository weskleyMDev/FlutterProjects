import 'package:admin_fribe/blocs/new_product_form/new_product_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NewProductScreen extends StatefulWidget {
  const NewProductScreen({super.key});

  @override
  State<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {
  late final TextEditingController _productNameController;
  late final NewProductFormBloc _newProductFormBloc;

  @override
  void initState() {
    super.initState();
    _productNameController = TextEditingController();
    _newProductFormBloc = BlocProvider.of<NewProductFormBloc>(context)
      ..add(const ResetProductForm());
  }

  @override
  void dispose() {
    _productNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Product')),
      body: BlocBuilder<NewProductFormBloc, NewProductFormState>(
        builder: (context, productState) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              TextField(
                key: const Key('productNameField'),
                controller: _productNameController,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                  errorText: productState.productNameErrorText,
                ),
                onChanged: (_) => _newProductFormBloc.add(
                  ProductNameChanged(_productNameController.text.trim()),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16.0),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _productNameController.clear();
                  GoRouter.of(context).pop();
                },
                child: const Text('Save Product'),
              ),
            ],
          );
        },
      ),
    );
  }
}
