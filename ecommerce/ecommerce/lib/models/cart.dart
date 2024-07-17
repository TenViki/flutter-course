import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';

class Cart extends ChangeNotifier {
  // list of products for sale
  List<Product> products = [
    Product(
      name: "Galaxy Z Fold 6",
      description: "The ultimate foldable powered by Galaxy AI",
      price: 1390.00,
      imagePath: "lib/img/product1.webp",
    ),
    Product(
      name: "Galaxy Watch Ultra",
      description:
          "Gear up for greatness with our toughest design yet, now enhanced with Galaxy AI.",
      price: 599.00,
      imagePath: "lib/img/product2.webp",
    ),
    Product(
      name: "Galaxy Buds 3",
      description:
          "Meet the Galaxy Buds designed to stay as active as you are.",
      price: 399.00,
      imagePath: "lib/img/product3.webp",
    ),
    Product(
      name: "Watch 7",
      description: "Start your everyday wellness journey",
      price: 499.00,
      imagePath: "lib/img/product4.webp",
    ),
  ];

  //list of items in the cart
  List<Product> cartItems = [];

  // get list of products for sale
  List<Product> getProducts() {
    return products;
  }

  // get cart
  List<Product> getCart() {
    return cartItems;
  }

  // add items to cart
  void addToCart(Product product) {
    cartItems.add(product);
    notifyListeners();
  }

  // remove items from cart
  void removeFromCart(Product product) {
    cartItems.remove(product);
    notifyListeners();
  }

  double getTotalPrice() {
    return cartItems.fold(
        0, (previousValue, element) => previousValue + element.price);
  }
}
