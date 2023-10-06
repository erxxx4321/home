import 'package:flutter/material.dart';
import 'package:home/models/product.dart';
import 'package:home/services/theme/app_theme.dart';
import 'package:intl/intl.dart';

class MyCard extends StatelessWidget {
  final Product product;

  MyCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Image.network(
            product.img, // Replace with your image URL
            width: 180, // Set the image width to the card width
            height: 220, // Set the desired image height
            fit: BoxFit.cover, // Adjust the BoxFit property as needed
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              textAlign: TextAlign.left,
              product.name,
              style: TextStyle(fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
                textAlign: TextAlign.left,
                '${NumberFormat.simpleCurrency(locale: 'zh-TW', decimalDigits: 2).format(product.price)}',
                style: TextStyle(fontSize: 12, color: AppTheme.primaryColor)),
          )
        ],
      ),
    );
  }
}
