import 'package:ecommerce_2/components/drawer_item.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.shopping_bag,
                  size: 72,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              DrawerItem(
                icon: Icons.home,
                title: "Home",
                onTap: () => Navigator.pop(context),
              ),
              DrawerItem(
                icon: Icons.shopping_cart,
                title: "Cart",
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/cart");
                },
              ),
              DrawerItem(
                icon: Icons.settings,
                title: "Settings",
                onTap: () => Navigator.pushNamed(context, "/shop"),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: DrawerItem(
              icon: Icons.logout,
              title: "Exit",
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                  context, "/intro", (route) => false),
            ),
          )
        ],
      ),
    );
  }
}
