import 'dart:convert';
import 'package:home/models/product.dart';
import 'package:flutter/material.dart';
import 'package:home/services/app_theme.dart';
import 'package:intl/intl.dart';
import '../services/I10n/app_localizations.dart';
import 'dart:developer' as developer;

class ProductView extends StatelessWidget {
  final Product product;
  ProductView({required this.product});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 5.0),
              width: double.infinity,
              child: Image.network(product.img, height: 350),
              padding: EdgeInsets.all(5.0),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5.0),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(color: Colors.white),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(product.name,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                          '${NumberFormat.simpleCurrency(locale: 'zh-TW', decimalDigits: 2).format(product.price)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor))),
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                          '${l10n.sold}: ${NumberFormat('#,##,000').format(product.amount)}'))
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(bottom: 5.0),
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(color: Colors.white),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(l10n.about)),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(product.desc, style: TextStyle(fontSize: 14)),
                    )
                  ],
                ))
          ]),
    );
  }
}
