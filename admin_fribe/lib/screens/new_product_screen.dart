import 'package:admin_fribe/blocs/new_product_form/new_product_form_bloc.dart';
import 'package:admin_fribe/blocs/new_product_form/validator/product_category_validator.dart';
import 'package:admin_fribe/blocs/new_product_form/validator/product_measure_validator.dart';
import 'package:admin_fribe/models/product_model.dart';
import 'package:admin_fribe/utils/capitalize_text.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NewProductScreen extends StatefulWidget {
  const NewProductScreen({super.key, this.initialProduct});

  final ProductModel? initialProduct;

  @override
  State<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {
  late final TextEditingController _productNameController;
  late final TextEditingController _productQuantityController;
  late final TextEditingController _productPriceController;
  late final NewProductFormBloc _newProductFormBloc;

  @override
  void initState() {
    super.initState();

    _productNameController = TextEditingController();
    _productQuantityController = TextEditingController();
    _productPriceController = TextEditingController();

    _newProductFormBloc = BlocProvider.of<NewProductFormBloc>(context);

    final initialProduct = widget.initialProduct;
    if (initialProduct != null) {
      _productNameController.text = initialProduct.name;
      _productQuantityController.text = initialProduct.amount;
      _productPriceController.text = initialProduct.price;

      _newProductFormBloc
        ..add(ProductNameChanged(initialProduct.name))
        ..add(ProductQuantityChanged(initialProduct.amount))
        ..add(ProductPriceChanged(initialProduct.price))
        ..add(ProductMeasureChanged(initialProduct.measure))
        ..add(ProductCategoryChanged(initialProduct.category));
    } else {
      _newProductFormBloc.add(const ResetProductForm());
    }
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _productQuantityController.dispose();
    _productPriceController.dispose();
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
                key: const ValueKey('productNameField'),
                controller: _productNameController,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                  errorText: productState.productNameErrorText,
                ),
                onChanged: (value) => _newProductFormBloc.add(
                  ProductNameChanged(value.trim().capitalize()),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                key: const ValueKey('productQuantityField'),
                decoration: InputDecoration(
                  labelText: 'Product Quantity',
                  border: OutlineInputBorder(),
                  errorText: productState.productQuantityErrorText,
                ),
                onChanged: (value) => _newProductFormBloc.add(
                  ProductQuantityChanged(value.trim().replaceAll(',', '.')),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                key: const ValueKey('productPriceField'),
                decoration: InputDecoration(
                  labelText: 'Product Price',
                  border: OutlineInputBorder(),
                  errorText: productState.productPriceErrorText,
                ),
                onChanged: (value) => _newProductFormBloc.add(
                  ProductPriceChanged(value.trim().replaceAll(',', '.')),
                ),
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<ProductMeasure>(
                initialValue: ProductMeasure.values.firstWhereOrNull(
                  (e) =>
                      e.name.trim().toUpperCase() ==
                      productState.productMeasure.value,
                ),
                items: ProductMeasure.values
                    .map(
                      (measure) => DropdownMenuItem(
                        value: measure,
                        child: Text(measure.name.capitalize()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    _newProductFormBloc.add(
                      ProductMeasureChanged(value.name.trim().toUpperCase()),
                    );
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Select a Measure',
                  border: OutlineInputBorder(),
                  errorText: productState.productMeasureErrorText,
                ),
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<ProductCategory>(
                initialValue: ProductCategory.values.firstWhereOrNull(
                  (e) =>
                      e.name.trim().toUpperCase() ==
                      productState.productCategory.value,
                ),
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
                      ProductCategoryChanged(value.name.trim().toUpperCase()),
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
                onPressed: productState.isFormValid
                    ? () {
                        _newProductFormBloc.add(const FormSubmitted());
                        GoRouter.of(context).pop();
                      }
                    : null,
                child: const Text('Save Product'),
              ),
            ],
          );
        },
      ),
    );
  }
}
