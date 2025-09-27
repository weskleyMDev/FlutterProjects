import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_fribe/blocs/cart/cart_bloc.dart';
import 'package:seller_fribe/blocs/products/product_bloc.dart';
import 'package:seller_fribe/widgets/product_tile.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({
    super.key,
    required this.productBloc,
    required this.cartBloc,
  });
  final ProductBloc productBloc;
  final CartBloc cartBloc;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state.status == ProductStatus.loading) {
          return Container(
            color: Colors.black87,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        final products = state.filteredProducts;
        return Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      labelText: 'Pesquisar produto',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => widget.productBloc.add(
                      ProductSearchQueryChanged(value.trim()),
                    ),
                  ),
                ),
                Expanded(
                  child: products.isNotEmpty
                      ? ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return ProductTile(
                              product: product,
                              cartBloc: widget.cartBloc,
                            );
                          },
                        )
                      : const Center(child: Text('Nenhum produto encontrado')),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
