// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:minimal_country_explorer/project/country_list/presentation/widgets/country_list_tile.dart';
//
// import '../providers/country_provider.dart';
//
// class FavoritesView extends ConsumerWidget {
//   const FavoritesView({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final countriesAsync = ref.watch(countriesProvider);
//
//     return countriesAsync.when(
//       data: (countries) {
//         final favorites = countries.where((country) => country.isFavorite).toList();
//
//         if (favorites.isEmpty) {
//           return const Center(
//             child: Text('No favorite countries yet'),
//           );
//         }
//
//         return ListView.builder(
//           itemCount: favorites.length,
//           itemBuilder: (context, index) {
//             return CountryListTile(country: favorites[index]);
//           },
//         );
//       },
//       loading: () => const Center(child: CircularProgressIndicator()),
//       error: (error, stack) => Center(child: Text('Error: $error')),
//     );
//   }
// }