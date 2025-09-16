import 'package:admin_fribe/blocs/new_product_form/new_product_form_bloc.dart';
import 'package:admin_fribe/blocs/new_product_form/validator/product_category_validator.dart';
import 'package:admin_fribe/utils/capitalize_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                onChanged: (value) =>
                    _newProductFormBloc.add(ProductNameChanged(value.trim())),
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<ProductCategory>(
                items: ProductCategory.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name.capitalize()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    _newProductFormBloc.add(
                      ProductCategoryChanged(value.name.trim()),
                    );
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Select a Category',
                  border: OutlineInputBorder(),
                  errorText: productState.productCategoryErrorText,
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: productState.isFormEmpty
                    ? null
                    : () {
                        _newProductFormBloc.add(const ValidateForm());
                        if (!productState.isFormValid) {
                          ScaffoldMessenger.of(context)
                            ..clearSnackBars()
                            ..showSnackBar(
                              SnackBar(
                                content: Text(
                                  productState.errorMessage ?? 'Unknown error!',
                                ),
                              ),
                            );
                          return;
                        }
                        /* if (productState.isFormNotValid) {
                          ScaffoldMessenger.of(context)
                            ..clearSnackBars()
                            ..showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please fix the errors in the form.',
                                ),
                              ),
                            );
                          return;
                        } else {
                          GoRouter.of(context).pop();
                        } */
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
