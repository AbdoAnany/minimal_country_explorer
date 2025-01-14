// lib/presentation/screens/favorites_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_country_explorer/presentation/widgets/country_card.dart';

import '../providers/country_provider.dart';
import '../widgets/shimmer_loading.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/country_provider.dart';
import '../widgets/country_card.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: favorites.isEmpty
          ? const Center(child: Text('No favorites found'))
          : ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 8),
        itemCount: favorites.length,
        itemBuilder: (context, index) => CountryCard(country: favorites[index]),
      ),
    );
  }
}
