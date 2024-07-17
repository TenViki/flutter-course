import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavbar extends StatelessWidget {
  final Function(int index)? onTabChange;
  const BottomNavbar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: GNav(
        color: Colors.grey,
        onTabChange: onTabChange,
        activeColor: const Color.fromRGBO(11, 32, 137, 1),
        tabBackgroundColor: const Color.fromRGBO(11, 32, 137, .1),
        mainAxisAlignment: MainAxisAlignment.center,
        gap: 10,
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            margin: EdgeInsets.only(right: 10),
          ),
          GButton(
            icon: Icons.shopping_cart,
            text: 'Cart',
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          ),
        ],
      ),
    );
  }
}
