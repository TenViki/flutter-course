import 'package:ecommerce_2/components/button.dart';
import 'package:ecommerce_2/components/cart_item.dart';
import 'package:ecommerce_2/models/shop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Shop>().cart;

    double getTotal() => cart.fold(0, (total, item) {
          return total + item.product.price * item.quantity;
        });

    void onPay() {
      // show snack barě
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Payment successful",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: cart.isEmpty
                ? const Center(child: Text("Your cart is empty..."))
                : ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      return CartListTile(cartItem: cart[index]);
                    },
                  ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total:",
                  style: TextStyle(fontSize: 20),
                ),
                Text("\$${getTotal().toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Button(
              onTap: onPay,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Pay now",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),

          // pay buttin
        ],
      ),
    );
  }
}
