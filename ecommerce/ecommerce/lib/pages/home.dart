import 'package:ecommerce/components/bottom_navbar.dart';
import 'package:ecommerce/pages/cart.dart';
import 'package:ecommerce/pages/shop.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const ShopPage(),
    const CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: BottomNavbar(
        onTabChange: _onItemTapped,
      ),
      appBar: AppBar(
        title: const Text('Samsung Store'),
        leading: Builder(builder: (context) {
          return Container(
            margin: const EdgeInsets.only(left: 12),
            child: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          );
        }),
        backgroundColor: Colors.transparent,
      ),
      body: _pages[_selectedIndex],
      drawer: Drawer(
          backgroundColor: Colors.grey[200],
          child: Column(
            children: [
              DrawerHeader(
                  child: Image.asset(
                "lib/img/logo.png",
              )),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pushNamed(context, "/home");
                },
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('About'),
                onTap: () {
                  Navigator.pushNamed(context, "/about");
                },
              ),
              Expanded(
                child: ListTile(
                  leading: const Icon(Icons.shopping_cart),
                  title: const Text('Cart'),
                  onTap: () {
                    Navigator.pushNamed(context, "/cart");
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Log out'),
                onTap: () {},
              ),
            ],
          )),
    );
  }
}
