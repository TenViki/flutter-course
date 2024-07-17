import 'package:ecommerce_2/components/button.dart';
import 'package:ecommerce_2/models/product.dart';
import 'package:ecommerce_2/models/shop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile({super.key, required this.product});

  void addToCart(BuildContext context) {
    // Add product to cart

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add this product to cart?"),
        content: Text(
          "Would you like to add ${product.name} to your cart?",
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all(
                Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<Shop>().addToCart(product);
            },
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all(
                Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(29),
      ),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(24),
              width: double.infinity,
              child: Image.asset(product.image),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            product.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              product.description,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                "\$${product.price.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 16),
              ),
              const Spacer(),
              Button(
                onTap: () => addToCart(context),
                padding: 16,
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
