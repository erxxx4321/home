import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:home/models/cart_item.dart';
import 'package:home/models/user.dart';
import 'package:home/services/app_config.dart';
import 'package:home/services/app_theme.dart';
import 'package:home/services/shared_preference.dart';
import 'package:home/widgets/button.dart';
import 'package:home/widgets/cart_widget.dart';
import 'package:http/http.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Future<User> getUser() => UserPreferences().getUser();
  late Future<List<Cart_Item>> cart_items;

  void initState() {
    super.initState();
    getUser().then((user) => {
          setState(
            () {
              cart_items = getCartItems(user.uid);
            },
          )
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.max, children: [
      FutureBuilder<List<Cart_Item>>(
          future: cart_items,
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Show loading indicator while waiting for data
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('您的購物車沒有商品');
            } else {
              return Container(
                  child: ListView.builder(
                itemCount: snapshot.data!.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CartWidget(cart_item: snapshot.data![index]);
                },
              ));
            }
          })),
      Container(
          margin: EdgeInsets.only(top: 30.0, left: 15.0, right: 15.0),
          child: longButtons("去買單", () {}, AppTheme.primaryColor))
    ]));
  }
}

Future<List<Cart_Item>> getCartItems(String? user_id) async {
  Response response = await post(Uri.parse(AppConfig.cart + "/getItems"),
      body: json.encode({'user_id': user_id}),
      headers: {"Content-Type": "application/json"});

  List<Cart_Item> cart_items = [];
  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body);
    for (var j in jsonData) {
      Cart_Item cart_item = Cart_Item.fromJson(j);
      cart_items.add(cart_item);
    }
  } else
    throw Exception('Failed to fetch data');

  return cart_items;
}
