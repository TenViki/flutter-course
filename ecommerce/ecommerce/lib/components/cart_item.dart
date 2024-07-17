import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final Product product;
  final void Function()? removeFromCart;
  const CartItem(
      {super.key, required this.product, required this.removeFromCart});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: ListTile(
        leading: Image.asset(
          product.imagePath,
          width: 70,
        ),
        title: Text(product.name),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        subtitle: Text("\$${product.price}"),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: removeFromCart,
        ),
      ),
    );
  }
}
