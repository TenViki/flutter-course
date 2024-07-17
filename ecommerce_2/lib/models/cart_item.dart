import 'package:ecommerce_2/models/product.dart';
import 'package:flutter/material.dart';

class CartItem extends ChangeNotifier {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });

  void increment() {
    quantity++;
    notifyListeners();
  }

  void decrement() {
    quantity--;
    notifyListeners();
  }
}
