import 'package:flutter/material.dart';
import 'package:home/providers/auth_provider.dart';
import 'package:home/screens/login_screen.dart';
import 'package:home/screens/register_screen.dart';
import 'package:provider/provider.dart';
import './services/I10n/app_localizations.dart';
import 'screens/home_screen.dart';
import 'services/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
        child: MaterialApp(
            locale: const Locale('zh'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
            theme: AppTheme,
            home: HomeScreen(),
            routes: {
              '/login': (context) => LoginScreen(),
              '/register': (context) => RegisterScreen()
            }));
  }
}
