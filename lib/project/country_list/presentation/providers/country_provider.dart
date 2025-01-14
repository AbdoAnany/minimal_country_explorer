// // lib/providers/country_provider.dart
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:minimal_country_explorer/project/country_list/data/local/data_sources/database_helper.dart';
// import 'package:minimal_country_explorer/project/country_list/data/remote/data_sources/api_service.dart';
// import 'package:minimal_country_explorer/project/country_list/data/repositories/country_repository.dart';
// import 'package:minimal_country_explorer/project/country_list/domain/entities/country.dart';
//
// // API Service Provider
// final apiServiceProvider = Provider<CountryApiService>((ref) {
//   return CountryApiService();
// });
//
// // Database Helper Provider
// final databaseHelperProvider = Provider<DatabaseHelper>((ref) {
//   return DatabaseHelper.instance;
// });
//
// // Repository Provider with dependencies
// final countryRepositoryProvider = Provider<CountryRepository>((ref) {
//   final apiService = ref.watch(apiServiceProvider);
//   final databaseHelper = ref.watch(databaseHelperProvider);
//   return CountryRepository(apiService, databaseHelper);
// });
//
// // Country State Provider
// final countriesProvider = StateNotifierProvider<CountryStateNotifier, CountryState>((ref) {
//   final repository = ref.watch(countryRepositoryProvider);
//   return CountryStateNotifier(repository);
// });
//
// class CountryStateNotifier extends StateNotifier<CountryState> {
//   final CountryRepository _repository;
//
//   CountryStateNotifier(this._repository) : super(CountryState()) {
//     fetchCountries();
//   }
//
//   Future<void> fetchCountries() async {
//     try {
//       state = state.copyWith(isLoading: true, error: null);
//
//       // Fetch countries and favorites concurrently
//       final countries = await _repository.fetchCountries();
//       final favorites = await _repository.getFavorites();
//
//       // Create a set of favorite country official names for efficient lookup
//       final favoriteNames = favorites.map((c) => c.name?.official ?? '').toSet();
//
//       // Update countries with correct favorite status
//       final updatedCountries = countries.map((country) {
//         final isFavorite = favoriteNames.contains(country.name?.official);
//         return country.copyWith(isFavorite: isFavorite);
//       }).toList();
//
//       state = state.copyWith(
//         countries: updatedCountries,
//         isLoading: false,
//       );
//     } catch (e) {
//       state = state.copyWith(
//         isLoading: false,
//         error: 'Failed to fetch countries: ${e.toString()}',
//       );
//     }
//   }
//
//   Future<void> toggleFavorite(Country country) async {
//     try {
//       final officialName = country.name?.official;
//       if (officialName == null) {
//         throw Exception('Country has no official name');
//       }
//
//       // Update in-memory state first for immediate UI feedback
//       final updatedCountries = List<Country>.from(state.countries);
//       final countryIndex = updatedCountries.indexWhere((c) => c.name?.official == officialName);
//
//       if (countryIndex == -1) return;
//
//       final updatedCountry = country.copyWith(isFavorite: !country.isFavorite);
//       updatedCountries[countryIndex] = updatedCountry;
//
//       state = state.copyWith(countries: updatedCountries);
//
//       // Then update the database
//       if (updatedCountry.isFavorite) {
//         await _repository.saveToFavorites(updatedCountry);
//       } else {
//         await _repository.deleteFromFavorites(updatedCountry);
//       }
//     } catch (e) {
//       // If database operation fails, revert the UI state
//       state = state.copyWith(error: 'Failed to update favorites: ${e.toString()}');
//       await fetchCountries(); // Refresh to ensure UI matches database state
//     }
//   }
// }
//
// // Derived Providers
// final favoriteCountriesProvider = Provider<List<Country>>((ref) {
//   final state = ref.watch(countriesProvider);
//   return state.countries.where((country) => country.isFavorite).toList();
// });
//
// final searchQueryProvider = StateProvider<String>((ref) => '');
//
// final filteredCountriesProvider = FutureProvider<List<Country>>((ref) async {
//   final repository = ref.watch(countryRepositoryProvider);
//   final countries = await repository.fetchCountries();
//   final searchQuery = ref.watch(searchQueryProvider);
//
//   if (searchQuery.isEmpty) {
//     return countries;
//   }
//
//   return countries.where((country) {
//     final name = country.name?.official?.toLowerCase() ?? '';
//     return name.contains(searchQuery.toLowerCase());
//   }).toList();
// });
//
// // State class for better type safety
// class CountryState {
//   final List<Country> countries;
//   final bool isLoading;
//   final String? error;
//
//   CountryState({
//     this.countries = const [],
//     this.isLoading = false,
//     this.error,
//   });
//
//   CountryState copyWith({
//     List<Country>? countries,
//     bool? isLoading,
//     String? error,
//   }) {
//     return CountryState(
//       countries: countries ?? this.countries,
//       isLoading: isLoading ?? this.isLoading,
//       error: error ?? this.error,
//     );
//   }
// }