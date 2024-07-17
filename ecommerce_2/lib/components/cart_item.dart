import 'package:ecommerce_2/models/cart_item.dart';
import 'package:ecommerce_2/models/shop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartListTile extends StatelessWidget {
  final CartItem cartItem;
  const CartListTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final shop = context.watch<Shop>();

    return ListTile(
      title: Text(cartItem.product.name),
      subtitle: Text(cartItem.product.price.toStringAsFixed(2)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              shop.removeFromCart(cartItem);
            },
          ),
          Text(cartItem.quantity.toString()),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              shop.addToCart(cartItem.product);
            },
          ),
        ],
      ),
    );
  }
}
