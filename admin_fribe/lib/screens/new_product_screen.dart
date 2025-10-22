import 'package:admin_fribe/blocs/new_product_form/new_product_form_bloc.dart';
import 'package:admin_fribe/blocs/new_product_form/validator/product_category_validator.dart';
import 'package:admin_fribe/blocs/new_product_form/validator/product_measure_validator.dart';
import 'package:admin_fribe/models/product_model.dart';
import 'package:admin_fribe/repositories/products/product_repository.dart';
import 'package:admin_fribe/utils/capitalize_text.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key, this.initialProduct});

  final ProductModel? initialProduct;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewProductFormBloc(
        productRepository: context.read<IProductRepository>(),
        initialProduct: initialProduct,
      ),
      child: const EditProductView(),
    );
  }
}

class EditProductView extends StatefulWidget {
  const EditProductView({super.key});

  @override
  State<EditProductView> createState() => _EditProductViewState();
}

class _EditProductViewState extends State<EditProductView> {
  final _editProductFormKey = GlobalKey<FormState>();
  late final FocusNode _quantityFocusNode;
  late final FocusNode _priceFocusNode;

  @override
  void initState() {
    super.initState();
    _quantityFocusNode = FocusNode();
    _priceFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _quantityFocusNode.dispose();
    _priceFocusNode.dispose();
    super.dispose();
  }

  void _showErrorSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
          duration: const Duration(seconds: 2),
          margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
          behavior: SnackBarBehavior.floating,
          elevation: 6.0,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final newProductFormBloc = context.read<NewProductFormBloc>();
    return BlocConsumer<NewProductFormBloc, NewProductFormState>(
      listener: (context, productState) {
        if (productState.formStatus == FormzSubmissionStatus.success) {
          _showErrorSnackBar(
            context,
            productState.isNewProduct
                ? '${productState.productName.value} added successfully!'
                : '${productState.productName.value} updated successfully!',
            Theme.of(context).colorScheme.primary,
          );
          context.pop();
          newProductFormBloc.add(const ResetProductForm());
        } else if (productState.formStatus == FormzSubmissionStatus.failure) {
          _showErrorSnackBar(
            context,
            productState.errorMessage ?? 'An unknown error occurred.',
            Theme.of(context).colorScheme.error,
          );
        }
      },
      builder: (context, productState) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: Text(
                  productState.isNewProduct ? 'New Product' : 'Edit Product',
                ),
              ),
              body: Form(
                key: _editProductFormKey,
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    TextFormField(
                      key: const ValueKey('productNameField'),
                      initialValue: productState.productName.value,
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_quantityFocusNode);
                      },
                      decoration: InputDecoration(
                        labelText: 'Product Name',
                        border: OutlineInputBorder(),
                        errorText: productState.productNameErrorText,
                      ),
                      onChanged: (value) => newProductFormBloc.add(
                        ProductNameChanged(value.trim().toUpperCase()),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: const ValueKey('productQuantityField'),
                      initialValue: productState.productQuantity.value,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      focusNode: _quantityFocusNode,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      decoration: InputDecoration(
                        labelText: 'Product Quantity',
                        border: OutlineInputBorder(),
                        errorText: productState.productQuantityErrorText,
                      ),
                      onChanged: (value) => newProductFormBloc.add(
                        ProductQuantityChanged(
                          value.trim().replaceAll(',', '.'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: const ValueKey('productPriceField'),
                      initialValue: productState.productPrice.value,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      focusNode: _priceFocusNode,
                      decoration: InputDecoration(
                        labelText: 'Product Price',
                        border: OutlineInputBorder(),
                        errorText: productState.productPriceErrorText,
                      ),
                      onChanged: (value) => newProductFormBloc.add(
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
                          newProductFormBloc.add(
                            ProductMeasureChanged(
                              value.name.trim().toUpperCase(),
                            ),
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
                          newProductFormBloc.add(
                            ProductCategoryChanged(
                              value.name.trim().toUpperCase(),
                            ),
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
                    FilledButton(
                      onPressed: productState.isValid
                          ? () => newProductFormBloc.add(const FormSubmitted())
                          : null,
                      child: Text(
                        productState.isNewProduct
                            ? 'Save Product'
                            : 'Update Product',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (productState.formStatus == FormzSubmissionStatus.inProgress)
              Container(
                color: Colors.black54,
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        );
      },
    );
  }
}
