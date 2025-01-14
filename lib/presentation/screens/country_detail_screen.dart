import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import '../providers/country_provider.dart';
import '../../data/models/country_model.dart';

class CountryDetailScreen extends ConsumerWidget {
  final CountryModel country;

  const CountryDetailScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesNotifier = ref.read(favoritesNotifierProvider.notifier);
    final isFavorite = ref.watch(favoritesNotifierProvider).contains(country);

    return Scaffold(
      appBar: AppBar(
        title: Text(country.name!.common!),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Iconsax.heart5 : Iconsax.heart,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              if (isFavorite) {
                favoritesNotifier.removeFavorite(country);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Removed from favorites')),
                );
              } else {
                favoritesNotifier.addFavorite(country);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Added to favorites')),
                );
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(country.flags!.png!),
            Text('Official: ${country.name?.official}'),
            Text('Capital: ${country.capital}'),
            Text('Population: ${country.population}'),
          ],
        ),
      ),
    );
  }
}
