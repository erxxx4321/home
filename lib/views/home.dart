import 'package:flutter/material.dart';
import '../services/I10n/app_localizations.dart';
import '../widgets/drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        drawer: DrawerWidget(),
        body: Column(
          children: [Text(l10n.hello)],
        ));
  }
}
