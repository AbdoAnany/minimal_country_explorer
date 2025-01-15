import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_country_explorer/presentation/screens/country_list_screen.dart';
import 'package:minimal_country_explorer/presentation/screens/favorites_screen.dart';

import 'core/const/app_color.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minimal Country Explorer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: AppColor.colorBg,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColor.colorBg,
          )),
      home: const CountryListScreen(),
      routes: {
        '/favorites': (context) => const FavoritesScreen(),
      },
    );
  }
}
