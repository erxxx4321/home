import 'dart:convert';
import 'dart:developer';
import 'package:home/screens/account_screen.dart';
import 'package:home/screens/cart_screen.dart';
import 'package:home/screens/favorite_screen.dart';
import 'package:home/screens/notification_screen.dart';
import 'package:home/screens/shop_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:home/services/I10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 2;
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final _pages = [
      CartScreen(),
      FavoriteScreen(),
      ShopScreen(),
      NotificationScreen(),
      AccountScreen()
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              // if (_selectedIndex == 0) {
              //   Navigator.push(
              //       context,
              //       PageTransition(
              //           child: const CartScreen(),
              //           type: PageTransitionType.rightToLeft));
              // }
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                ),
                label: l10n.cart),
            BottomNavigationBarItem(
                icon: const Icon(Icons.favorite), label: l10n.favorite),
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.local_mall,
                ),
                label: l10n.shop),
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.notifications_none,
                ),
                label: l10n.notification),
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.account_circle,
                ),
                label: l10n.my),
          ]),
    );
  }
}
