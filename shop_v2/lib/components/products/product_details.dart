import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_v2/l10n/app_localizations.dart';
import 'package:shop_v2/models/products/product_model.dart';
import 'package:shop_v2/stores/auth/auth.store.dart';
import 'package:shop_v2/stores/cart/cart.store.dart';
import 'package:shop_v2/stores/products/products.store.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.pid});

  final String pid;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final productsStore = GetIt.instance<ProductsStore>();
  final authStore = GetIt.instance<AuthStore>();
  final cartStore = GetIt.instance<CartStore>();

  @override
  void dispose() {
    productsStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final maxHeigh = MediaQuery.of(context).size.height;
    final maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Observer(
          builder: (_) {
            final product = productsStore.productsList.firstWhere(
              (element) => element.id == widget.pid,
              orElse: () => ProductModel.empty(),
            );
            return Text(product.title[locale] ?? 'Error');
          },
        ),
      ),
      body: Observer(
        builder: (context) {
          final product = productsStore.productsList.firstWhere(
            (element) => element.id == widget.pid,
            orElse: () => ProductModel.empty(),
          );
          return Stack(
            children: [
              ListView(
                padding: const EdgeInsets.all(10.0),
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    child: CarouselSlider.builder(
                      itemCount: product.images.length,
                      itemBuilder: (context, index, _) {
                        return FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: product.images[index],
                          fit: BoxFit.cover,
                          width: maxWidth,
                          height: maxHeigh * 0.4,
                        );
                      },
                      options: CarouselOptions(
                        height: maxHeigh * 0.5,
                        viewportFraction: 0.9,
                        enableInfiniteScroll: true,
                        enlargeCenterPage: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 5),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    child: Text(product.title[locale] ?? 'Error'),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      'R\$ ${product.price}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    child: Text(AppLocalizations.of(context)!.size),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    height: maxHeigh * 0.05,
                    child: ListView.builder(
                      itemCount: product.sizes.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Observer(
                          builder: (_) {
                            final size = product.sizes[index];
                            final isSelected =
                                productsStore.selectedSize == index;
                            return Container(
                              margin: const EdgeInsets.only(right: 5.0),
                              child: ChoiceChip(
                                label: Text(size),
                                selected: isSelected,
                                onSelected: (_) {
                                  productsStore.selectedSize = index;
                                },
                                selectedColor: Theme.of(
                                  context,
                                ).colorScheme.inversePrimary,
                                showCheckmark: false,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: productsStore.selectedSize == null
                        ? null
                        : () async {
                            if (authStore.currentUser != null) {
                              cartStore.isLoading = true;
                              await cartStore.addToCart(
                                product,
                                authStore.currentUser!.id!,
                                productsStore.selectedSize!,
                              );
                              cartStore.isLoading = false;
                              if (!context.mounted) return;
                              context.pushNamed('cart-screen');
                            } else {
                              context.goNamed('login-screen');
                            }
                          },
                    child: Text(
                      authStore.currentUser == null
                          ? AppLocalizations.of(context)!.enter_to_buy
                          : AppLocalizations.of(context)!.add_to_cart,
                    ),
                  ),
                ],
              ),
              if (cartStore.isLoading)
                Container(
                  height: double.infinity,
                  width: double.infinity,
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
