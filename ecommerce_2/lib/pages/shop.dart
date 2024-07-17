import 'package:ecommerce_2/components/main_drawer.dart';
import 'package:ecommerce_2/components/product_tile.dart';
import 'package:ecommerce_2/models/shop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.watch<Shop>().products;

    return Scaffold(
      appBar: AppBar(
        title: Text("Store Minimal"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: MainDrawer(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: ListView(
        children: [
          const SizedBox(height: 24),
          const Center(
            child: Text(
              "Pick from the best products",
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(
            height: 550,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return ProductTile(product: product);
              },
            ),
          ),
        ],
      ),
    );
  }
}
