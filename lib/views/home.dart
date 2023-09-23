import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:home/models/product.dart';
import 'package:intl/intl.dart';
import '../services/I10n/app_localizations.dart';
import '../widgets/drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _tabs = [
    Tab(text: 'chair', height: 30),
    Tab(text: 'table', height: 30),
    Tab(text: 'bed', height: 30),
    Tab(text: 'lighting', height: 30),
    Tab(text: 'sofa', height: 30),
    Tab(text: 'cabinet', height: 30),
  ];
  Future<List<Product>> products = getProducts("chair");

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        drawer: DrawerWidget(),
        body: Column(
          children: [
            TabBar(
              isScrollable: true,
              controller: _tabController,
              tabs: _tabs,
              onTap: (idx) async {
                products = getProducts(_tabs[idx].text);
              },
            )
          ],
        ));
  }
}

Future<List<Product>> getProducts(String? category) async {
  final url = "http://localhost:3001/products";
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
      products.add(p);
    }
  } else
    throw Exception('Failed to fetch data');

  return products;
}
