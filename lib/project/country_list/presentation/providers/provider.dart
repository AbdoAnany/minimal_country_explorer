// // lib/providers/country_providers.dart
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:minimal_country_explorer/project/country_list/data/local/data_sources/database_helper.dart';
// import 'package:minimal_country_explorer/project/country_list/data/remote/data_sources/api_service.dart';
// import 'package:minimal_country_explorer/project/country_list/data/repositories/country_repository.dart';
// import 'package:minimal_country_explorer/project/country_list/domain/entities/country.dart';
//
// // Providers for dependencies
// final apiServiceProvider = Provider<CountryApiService>((ref) {
//   return CountryApiService();
// });
//
// final databaseHelperProvider = Provider<DatabaseHelper>((ref) {
//   return DatabaseHelper.instance;
// });
//
// // Repository provider with dependencies injection
// final countryRepositoryProvider = Provider<CountryRepository>((ref) {
//   final apiService = ref.watch(apiServiceProvider);
//   final databaseHelper = ref.watch(databaseHelperProvider);
//   return CountryRepository(apiService, databaseHelper);
// });
//
// // Main state class
// class CountriesState {
//   final List<Country> countries;
//   final bool isLoading;
//   final String? error;
//
//   CountriesState({
//     this.countries = const [],
//     this.isLoading = false,
//     this.error,
//   });
//
//   CountriesState copyWith({
//     List<Country>? countries,
//     bool? isLoading,
//     String? error,
//   }) {
//     return CountriesState(
//       countries: countries ?? this.countries,
//       isLoading: isLoading ?? this.isLoading,
//       error: error,
//     );
//   }
// }
//
// // Main country provider
// final countriesProvider = StateNotifierProvider<CountriesNotifier, CountriesState>((ref) {
//   final repository = ref.watch(countryRepositoryProvider);
//   return CountriesNotifier(repository);
// });
//
// class CountriesNotifier extends StateNotifier<CountriesState> {
//   final CountryRepository _repository;
//
//   CountriesNotifier(this._repository) : super(CountriesState()) {
//     loadCountries();
//   }
//
//   Future<void> loadCountries() async {
//     try {
//       state = state.copyWith(isLoading: true, error: null);
//
//       // Fetch countries and favorites
//       final countries = await _repository.fetchCountries();
//       final favorites = await _repository.getFavorites();
//
//       // Create set of favorite country names for efficient lookup
//       final favoriteNames = favorites.map((c) => c.name?.official ?? '').toSet();
//
//       // Update countries with favorite status
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
//         error: e.toString(),
//       );
//     }
//   }
//
//   Future<void> toggleFavorite(Country country) async {
//     try {
//       // Update local state first for immediate UI feedback
//       final updatedCountries = List<Country>.from(state.countries);
//       final index = updatedCountries.indexWhere(
//               (c) => c.name?.official == country.name?.official
//       );
//
//       if (index != -1) {
//         final updatedCountry = country.copyWith(isFavorite: !country.isFavorite);
//         updatedCountries[index] = updatedCountry;
//
//         state = state.copyWith(countries: updatedCountries);
//
//         // Update database
//         if (updatedCountry.isFavorite) {
//           await _repository.saveToFavorites(updatedCountry);
//         } else {
//           await _repository.deleteFromFavorites(updatedCountry);
//         }
//       }
//     } catch (e) {
//       state = state.copyWith(error: 'Failed to update favorite: ${e.toString()}');
//       // Refresh to ensure UI matches database state
//       await loadCountries();
//     }
//   }
//
//   // Method to refresh countries list
//   Future<void> refresh() async {
//     await loadCountries();
//   }
// }
//
// // Search query provider
// final searchQueryProvider = StateProvider<String>((ref) => '');
//
// // Filtered countries provider
// final filteredCountriesProvider = Provider<List<Country>>((ref) {
//   final state = ref.watch(countriesProvider);
//   final searchQuery = ref.watch(searchQueryProvider).toLowerCase();
//
//   if (searchQuery.isEmpty) {
//     return state.countries;
//   }
//
//   return state.countries.where((country) {
//     final name = country.name?.official?.toLowerCase() ?? '';
//     return name.contains(searchQuery);
//   }).toList();
// });
//
// // Favorites provider
// final favoritesProvider = Provider<List<Country>>((ref) {
//   final state = ref.watch(countriesProvider);
//   return state.countries.where((country) => country.isFavorite).toList();
// });
//
// // Example usage in a widget:
// /*
// class CountryListScreen extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(countriesProvider);
//     final countries = ref.watch(filteredCountriesProvider);
//
//     if (state.isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }
//
//     if (state.error != null) {
//       return Center(child: Text(state.error!));
//     }
//
//     return ListView.builder(
//       itemCount: countries.length,
//       itemBuilder: (context, index) {
//         final country = countries[index];
//         return ListTile(
//           title: Text(country.name?.official ?? ''),
//           trailing: IconButton(
//             icon: Icon(
//               country.isFavorite ? Icons.favorite : Icons.favorite_border,
//             ),
//             onPressed: () {
//               ref.read(countriesProvider.notifier).toggleFavorite(country);
//             },
//           ),
//         );
//       },
//     );
//   }
// }
// */