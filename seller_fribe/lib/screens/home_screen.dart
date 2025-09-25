import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:seller_fribe/blocs/auth/auth_bloc.dart';
import 'package:seller_fribe/blocs/cart/cart_bloc.dart';
import 'package:seller_fribe/blocs/products/product_bloc.dart';
import 'package:seller_fribe/cubits/home_tab/home_tab_cubit.dart';
import 'package:seller_fribe/screens/cart_screen.dart';
import 'package:seller_fribe/screens/products_screen.dart';
import 'package:seller_fribe/widgets/user_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AuthBloc _authBloc;
  late final HomeTabCubit _homeTabCubit;
  late final ProductBloc _productBloc;
  late final CartBloc _cartBloc;
  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _homeTabCubit = BlocProvider.of<HomeTabCubit>(context);
    _productBloc = BlocProvider.of<ProductBloc>(context);
    _cartBloc = BlocProvider.of<CartBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NOVA VENDA'), centerTitle: true),
      drawer: UserDrawer(authBloc: _authBloc),
      body: BlocBuilder<HomeTabCubit, HomeTabState>(
        builder: (context, state) {
          return IndexedStack(
            index: state.currentTab.index,
            children: [
              ProductsScreen(productBloc: _productBloc, cartBloc: _cartBloc),
              CartScreen(cartBloc: _cartBloc),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(FontAwesome5.cubes),
              iconSize: 28.0,
              onPressed: () => _homeTabCubit.switchTab(HomeTabs.products),
            ),
            IconButton(
              icon: const Icon(FontAwesome5.shopping_cart),
              onPressed: () => _homeTabCubit.switchTab(HomeTabs.cart),
            ),
          ],
        ),
      ),
    );
  }
}
