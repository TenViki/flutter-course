import 'package:ecommerce/components/cart_item.dart';
import 'package:ecommerce/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("My Cart",
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: value.getCart().length,
                itemBuilder: (context, index) {
                  final item = value.getCart()[index];
                  return CartItem(
                    product: item,
                    removeFromCart: () => value.removeFromCart(item),
                  );
                },
              ),
            ),
            Row(children: [
              Expanded(
                child:
                    const Text("Total:", style: const TextStyle(fontSize: 20)),
              ),
              Text("\$${value.getTotalPrice()}",
                  style: const TextStyle(fontSize: 20)),
            ])
          ],
        ),
      ),
    );
  }
}
