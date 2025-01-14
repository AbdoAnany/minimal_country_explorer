// lib/presentation/providers/country_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_country_explorer/data/datasources/country_api_service.dart';
import 'package:minimal_country_explorer/data/datasources/database_helper.dart';
import 'package:minimal_country_explorer/data/models/country_model.dart';

import 'favorites_notifier.dart';

final apiServiceProvider = Provider<CountryApiService>((ref) => CountryApiService());
final databaseHelperProvider = Provider<DatabaseHelper>((ref) => DatabaseHelper.instance);

final countriesProvider = FutureProvider<List<CountryModel>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return apiService.fetchCountries();
});

final favoritesNotifierProvider = StateNotifierProvider<FavoritesNotifier, List<CountryModel>>((ref) {
  final dbHelper = ref.read(databaseHelperProvider);
  return FavoritesNotifier(dbHelper);
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredCountriesProvider = FutureProvider<List<CountryModel>>((ref) async {
  final countriesAsync = ref.watch(countriesProvider);
  final searchQuery = ref.watch(searchQueryProvider);

  return countriesAsync.when(
    data: (countries) {
      if (searchQuery.isEmpty) return countries;
      return countries
          .where((country) => country.name!.common!.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    },
    loading: () => [],
    error: (error, stack) => throw error,
  );
});


