import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_fribe/blocs/auth/auth_bloc.dart';
import 'package:seller_fribe/blocs/products/product_bloc.dart';
import 'package:seller_fribe/widgets/product_tile.dart';
import 'package:seller_fribe/widgets/user_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AuthBloc _authBloc;
  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NOVA VENDA')),
      drawer: UserDrawer(authBloc: _authBloc),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          final products = state.products;
          if (products.isEmpty) {
            return const Center(child: Text('Nenhum produto encontrado.'));
          }
          return Stack(
            children: [
              ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductTile(product: product);
                },
              ),
              if (state.status == ProductStatus.loading)
                Container(
                  color: Colors.black87,
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
    );
  }
}
