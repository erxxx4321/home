import 'package:flutter/material.dart';
import '../services/I10n/app_localizations.dart';
import 'package:home/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'package:home/widgets/card.dart';
import 'package:intl/intl.dart';
import 'package:home/services/app_config.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Future<List<Product>> products = getProducts("chair");
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final _tabs = [
      Tab(text: l10n.chair, height: 30, value: 'chair'),
      Tab(text: l10n.table, height: 30, value: 'table'),
      Tab(text: l10n.bed, height: 30, value: 'bed'),
      Tab(text: l10n.sofa, height: 30, value: 'sofa'),
      Tab(text: l10n.cabinet, height: 30, value: 'cabinet'),
    ];
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          TabBar(
            isScrollable: true,
            controller: _tabController,
            tabs: _tabs,
            onTap: (idx) async {
              setState(() {
                products = getProducts(_tabs[idx].value);
              });
            },
          ),
          FutureBuilder<List<Product>>(
            future: products,
            builder:
                (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Show loading indicator while waiting for data
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('No data available');
              } else {
                return GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 8.0 / 13.0,
                  children: List.generate(snapshot.data!.length, (index) {
                    return Container(
                      child: MyCard(product: snapshot.data![index]),
                    );
                  }),
                );
              }
            },
          )
        ],
      ),
    );
  }
}

Future<List<Product>> getProducts(String? category) async {
  final url = '${AppConfig.localhost}/products';
  final response = await http.post(
    Uri.parse(url),
    body: jsonEncode({"category": category}),
    headers: {"Content-Type": "application/json"},
  );
  List<Product> products = [];
  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body);
    for (var j in jsonData) {
      Product p = Product();
      p.pid = j['_id'];
      p.name = j['name'];
      p.desc = j['desc'];
      p.category = j['category'];
      p.createdAt = DateFormat("yyyy/MM/dd").parse(j['createdAt']);
      p.price = j['price'];
      p.img = j['img'];
      p.soldQty = j['soldQty'];
      products.add(p);
    }
  } else
    throw Exception('Failed to fetch data');
  return products;
}
