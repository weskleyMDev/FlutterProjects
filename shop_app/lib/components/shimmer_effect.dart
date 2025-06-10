import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../models/product_list.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({super.key, required this.products});

  final ProductList products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.items.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 80, height: 80, color: Colors.white),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Container(height: 14, width: 150, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
