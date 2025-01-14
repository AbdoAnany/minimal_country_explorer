import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_country_explorer/project/country_list/data/local/data_sources/database_helper.dart';
import 'package:minimal_country_explorer/project/country_list/data/remote/data_sources/api_service.dart';
import 'package:minimal_country_explorer/project/country_list/data/repositories/country_repository.dart';
import 'package:minimal_country_explorer/project/country_list/presentation/pages/CountryListScreen.dart';
import 'package:minimal_country_explorer/project/country_list/presentation/pages/HomeScreen.dart';
// lib/main.dart
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
        appBarTheme: AppBarTheme(
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

// void main() {
//   runApp(
//     const ProviderScope(
//       child: CountryExplorerApp(),
//     ),
//   );
// }
//
// class CountryExplorerApp extends StatelessWidget {
//   const CountryExplorerApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Country Explorer',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         useMaterial3: true,
//       ),
//       home: const HomeScreen(),
//     );
//   }
// }




