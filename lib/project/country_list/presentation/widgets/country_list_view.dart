// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../providers/country_provider.dart';
// import 'country_list_tile.dart';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../providers/country_provider.dart';
// import 'country_list_tile.dart';
//
// class CountryListView extends ConsumerWidget {
//   final String searchQuery;
//
//   const CountryListView({super.key, required this.searchQuery});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final countriesAsync = ref.watch(filteredCountriesProvider);
//
//     return countriesAsync.when(
//       data: (countries) {
//         if (countries.isEmpty) {
//           return const Center(child: Text('No countries found.'));
//         }
//
//         final filteredCountries = countries
//             .where((country) =>
//             country.name!.common!.toLowerCase().contains(searchQuery.toLowerCase()))
//             .toList();
//
//         if (filteredCountries.isEmpty) {
//           return Center(
//             child: Text('No countries found for "$searchQuery".'),
//           );
//         }
//
//         return ListView.builder(
//           itemCount: filteredCountries.length,
//           itemBuilder: (context, index) {
//             final country = filteredCountries[index];
//             return CountryListTile(country: country);
//           },
//         );
//       },
//       loading: () => const Center(child: CircularProgressIndicator()),
//       error: (error, stack) => Center(child: Text('Error: $error')),
//     );
//   }
// }