import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:home/models/product.dart';
import 'package:home/models/user.dart';
import 'package:home/services/app_config.dart';
import 'package:home/services/app_theme.dart';
import 'package:home/services/shared_preference.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:home/screens/product_view.dart';
import 'package:page_transition/page_transition.dart';

class MyCard extends StatelessWidget {
  final Product product;

  MyCard({required this.product});

  @override
  Widget build(BuildContext context) {
    void addToCart(User user) async {
      Response response = await post(Uri.parse(AppConfig.cart + "/addItem"),
          body: json.encode({'user_id': user.uid, 'product_id': product.pid}),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        showDialog(
            context: context,
            builder: (context) => SimpleDialog(
                  contentPadding: EdgeInsets.all(30.0),
                  children: [Text('加入成功!')],
                ));
      } else {
        showDialog(
            context: context,
            builder: (context) => SimpleDialog(
                  title: Text(
                    '加入失敗!',
                    style: TextStyle(color: Colors.red),
                  ),
                  contentPadding: EdgeInsets.all(30.0),
                  children: [Text(response.body)],
                ));
      }
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: ProductScreen(product: product),
                type: PageTransitionType.rightToLeft));
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.all(6.0),
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(product.img,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.fitWidth // Replace with your image URL
                  ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Text(
                  textAlign: TextAlign.left,
                  product.name,
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                    textAlign: TextAlign.left,
                    '${NumberFormat.simpleCurrency(locale: 'zh-TW', decimalDigits: 2).format(product.price)}',
                    style:
                        TextStyle(fontSize: 12, color: AppTheme.primaryColor)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                      onPressed: () async {
                        var user = await UserPreferences().getUser();
                        addToCart(user);
                      },
                      icon: Icon(Icons.add_shopping_cart_sharp),
                      label: Text('加入購物車', style: TextStyle(fontSize: 12)),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => AppTheme.primaryColor)))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
