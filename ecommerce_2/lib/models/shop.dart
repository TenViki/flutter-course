import 'package:ecommerce_2/models/cart_item.dart';
import 'package:ecommerce_2/models/product.dart';
import 'package:flutter/material.dart';

class Shop extends ChangeNotifier {
  // products for sale
  final List<Product> _shop = [
    Product(
      name: "Mens Cotton Jacket",
      description: "Description 1",
      price: 100.0,
      image: "assets/product1.jpg",
    ),
    Product(
      name: "Product 2",
      description: "Description 2",
      price: 200.0,
      image: "assets/product2.jpg",
    ),
    Product(
      name: "Product 3",
      description: "Description 3",
      price: 300.0,
      image: "assets/product3.jpg",
    ),
    Product(
      name: "Product 4",
      description: "Description 4",
      price: 400.0,
      image: "assets/product4.jpg",
    ),
  ];

  // user cart
  List<CartItem> _cart = [];

  int simpleCounter = 0;

  void incrementCounter() {
    simpleCounter++;
    notifyListeners();
  }

  // get products
  List<Product> get products => _shop;

  // get user cart
  List<CartItem> get cart => _cart;

  // add item to cart
  void addToCart(Product item) {
    for (CartItem cartItem in _cart) {
      if (cartItem.product.name == item.name) {
        cartItem.increment();
        notifyListeners();
        return;
      }
    }

    _cart.add(CartItem(product: item, quantity: 1));

    notifyListeners();
  }

  // remove item from cart
  void removeFromCart(CartItem item) {
    for (CartItem cartItem in _cart) {
      if (cartItem.product.name == item.product.name) {
        cartItem.decrement();
        if (cartItem.quantity == 0) {
          _cart.remove(cartItem);
        }
        notifyListeners();
        return;
      }
    }

    notifyListeners();
  }
}
