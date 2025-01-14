import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_country_explorer/presentation/screens/country_list_screen.dart';
import 'package:minimal_country_explorer/presentation/screens/favorites_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minimal Country Explorer',
      theme: ThemeData(primarySwatch: Colors.blue,

      scaffoldBackgroundColor:  Color(0xFFf5f5f5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFf5f5f5),
        )
      ),
      home: const CountryListScreen(),
      routes: {
        '/favorites': (context) => FavoritesScreen(),
      },
    );
  }
}
