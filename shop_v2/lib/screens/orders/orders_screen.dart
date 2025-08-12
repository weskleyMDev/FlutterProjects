import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_v2/models/cart/cart_item.dart';
import 'package:shop_v2/models/products/product_model.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    final map = firestore
        .collection('users')
        .doc('LhAEA9YfPkOb7ae9RUecw6RBLrW2')
        .collection('cart')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList())
        .asBroadcastStream();
    map.listen((data) {
      print(data);
    });

    sendData() async {
      final product = ProductModel(
        id: 'p1',
        price: 'price',
        title: {'en': 'title'},
        images: [],
        sizes: [],
      );
      final data = CartItem(
        id: '',
        category: 'category',
        quantity: 1,
        size: 'size',
        product: product,
      );

      final docRef = await FirebaseFirestore.instance
          .collection('users')
          .doc('LhAEA9YfPkOb7ae9RUecw6RBLrW2')
          .collection('cart')
          .add(data.toMap());

      await docRef.set(data.copyWith(id: docRef.id).toMap());
    }

    deleteData() async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc('LhAEA9YfPkOb7ae9RUecw6RBLrW2')
          .collection('cart')
          .doc('items')
          .delete();
    }

    return Center(
      child: Column(
        children: [
          ElevatedButton(onPressed: sendData, child: Text('add')),
          ElevatedButton(onPressed: deleteData, child: Text('delete')),
        ],
      ),
    );
  }
}
