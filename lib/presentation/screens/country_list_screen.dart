// lib/presentation/screens/country_list_screen.dart
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minimal_country_explorer/presentation/widgets/country_card.dart';

import '../providers/country_provider.dart';
import '../widgets/shimmer_loading.dart';

class CountryListScreen extends ConsumerWidget {
  const CountryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final searchQuery = ref.watch(searchQueryProvider);
    final filteredCountriesAsync = ref.watch(filteredCountriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Navigator.pushNamed(context, '/favorites'),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (value) =>
                  ref.read(searchQueryProvider.notifier).state = value,
              decoration: InputDecoration(
                hintText: 'Search by name or capital...',
                prefixIcon: const Icon(Iconsax.search_normal_1),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: filteredCountriesAsync.when(
        data: (countries) => ListView.builder(
          itemCount: countries.length,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          itemBuilder: (context, index) => FadeInRight(
            duration: Duration(milliseconds: 150 * index),
            child: CountryCard(
              country: countries[index],
            ),
          ),
        ),
        loading: () => const ShimmerLoading(),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
