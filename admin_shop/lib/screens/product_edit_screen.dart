import 'package:admin_shop/blocs/product_edit/product_edit_bloc.dart';
import 'package:admin_shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class ProductEditScreen extends StatelessWidget {
  const ProductEditScreen({super.key, required this.category, this.product});

  final String category;
  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return BlocProvider(
      create: (context) =>
          ProductEditBloc(initialProduct: product, locale: locale),
      child: ProductEditForm(),
    );
  }
}

class ProductEditForm extends StatefulWidget {
  const ProductEditForm({super.key});

  @override
  State<ProductEditForm> createState() => _ProductEditFormState();
}

class _ProductEditFormState extends State<ProductEditForm> {
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  late final TextEditingController _imagesController;
  late final ProductEditBloc _productBloc;

  @override
  void initState() {
    super.initState();
    _productBloc = BlocProvider.of<ProductEditBloc>(context);
    _nameController = TextEditingController(
      text: _productBloc.state.productName.value,
    );
    _priceController = TextEditingController(
      text: _productBloc.state.productPrice.value,
    );
    _imagesController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _imagesController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return BlocConsumer<ProductEditBloc, ProductEditState>(
      listener: (context, state) {
        if (state.status == FormzSubmissionStatus.success) {
          _showSnackBar(
            state.isNewProduct
                ? 'Product added successfully!'
                : 'Product updated successfully!',
          );
          Navigator.of(context).pop();
        }
        if (state.status == FormzSubmissionStatus.failure) {
          _showSnackBar('Failed to submit product. Please try again.');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state.isNewProduct ? 'Add Product' : 'Edit Product'),
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _nameController,
                      onChanged: (_) => _productBloc.add(
                        ProductNameChanged(_nameController.text.trim()),
                      ),
                      decoration: InputDecoration(
                        labelText: 'Product Name',
                        errorText: state.productNameError,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _priceController,
                      onChanged: (_) => _productBloc.add(
                        ProductPriceChanged(_priceController.text.trim()),
                      ),
                      decoration: InputDecoration(
                        labelText: 'Price',
                        border: const OutlineInputBorder(),
                        errorText: state.productPriceError,
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _imagesController,
                      decoration: const InputDecoration(
                        labelText: 'Image URL',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: state.isValid
                          ? () {
                              _productBloc.add(
                                ProductEditSubmitted(locale: locale),
                              );
                              print(
                                'Product Submitted: ${state.productName.value}',
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      child: Text(
                        state.isNewProduct ? 'Add Product' : 'Save Changes',
                      ),
                    ),
                  ],
                ),
              ),
              if (state.status == FormzSubmissionStatus.inProgress)
                Container(
                  color: Colors.black54,
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        );
      },
    );
  }
}
