import 'package:ecommerce/components/product_tile.dart';
import 'package:ecommerce/models/cart.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    void addProductToCart(Product product) {
      final cart = Provider.of<Cart>(context, listen: false);
      cart.addToCart(product);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: const Text("Product added to cart"),
          duration: const Duration(milliseconds: 2500),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
        ),
      );
    }

    return Consumer<Cart>(
      builder: (context, value, child) => Column(
        children: [
          // search bar
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Search",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Shop all latest offers and innovations",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Best new products",
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  "see all",
                  style: TextStyle(
                      color: Color.fromRGBO(11, 32, 137, 1), fontSize: 16),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: value.getProducts().length,
              itemBuilder: (context, index) {
                Product product = value.getProducts()[index];

                return ProductTile(
                  product: product,
                  onAdd: () => addProductToCart(product),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
