import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_country_explorer/data/datasources/country_api_service.dart';
import 'package:minimal_country_explorer/data/datasources/database_helper.dart';
import 'package:minimal_country_explorer/data/models/country_model.dart';

import 'favorites_notifier.dart';

final apiServiceProvider = Provider<CountryApiService>((ref) => CountryApiService());
final databaseHelperProvider = Provider<DatabaseHelper>((ref) => DatabaseHelper.instance);

// Provider to get favorite countries from database
final favoriteIdsProvider = FutureProvider<List<String>>((ref) async {
  final dbHelper = ref.read(databaseHelperProvider);
  final favorites = await dbHelper.getFavorites();
  return favorites.map((country) => country.name?.official ?? '').toList();
});

// Modified countries provider that includes favorite status
final countriesProvider = FutureProvider<List<CountryModel>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  final favoritesAsync = ref.watch(favoriteIdsProvider);
  final favorites = ref.watch(favoritesNotifierProvider);

  return favoritesAsync.when(
    data: (favoriteIds) async {
      final countries = await apiService.fetchCountries();
      return countries.map((country) {
        final isFavorite = favorites.any((fav) =>
        fav.name?.official == country.name?.official);
        return country.copyWith(isFavorite: isFavorite);
      }).toList();
    },
    loading: () async {
      final countries = await apiService.fetchCountries();
      return countries.map((country) {
        final isFavorite = favorites.any((fav) =>
        fav.name?.official == country.name?.official);
        return country.copyWith(isFavorite: isFavorite);
      }).toList();
    },
    error: (_, __) async {
      final countries = await apiService.fetchCountries();
      return countries.map((country) {
        final isFavorite = favorites.any((fav) =>
        fav.name?.official == country.name?.official);
        return country.copyWith(isFavorite: isFavorite);
      }).toList();
    },
  );
});

final favoritesNotifierProvider = StateNotifierProvider<FavoritesNotifier, List<CountryModel>>((ref) {
  final dbHelper = ref.read(databaseHelperProvider);
  return FavoritesNotifier(dbHelper);
});

// Modified filtered countries provider
final filteredCountriesProvider = FutureProvider<List<CountryModel>>((ref) async {
  final countriesAsync = ref.watch(countriesProvider);
  final searchQuery = ref.watch(searchQueryProvider);

  return countriesAsync.when(
    data: (countries) {
      if (searchQuery.isEmpty) return countries;

      return countries
          .where((country) =>
      country.name?.common?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false)
          .toList();
    },
    loading: () => [],
    error: (error, stack) => throw error,
  );
});

final searchQueryProvider = StateProvider<String>((ref) => '');

// Updated toggle favorite provider
final toggleFavoriteProvider = Provider.family<Future<void>, CountryModel>((ref, country) async {
  final notifier = ref.read(favoritesNotifierProvider.notifier);
  final dbHelper = ref.read(databaseHelperProvider);

  await dbHelper.toggleFavorite(country);
  notifier.toggleFavorite(country);

  // Invalidate the providers to trigger UI updates
  ref.invalidate(favoriteIdsProvider);
  ref.invalidate(countriesProvider);
});