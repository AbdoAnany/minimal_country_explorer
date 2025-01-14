// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:minimal_country_explorer/project/country_list/presentation/providers/country_provider.dart';
//
// import 'FavoritesScreen.dart';
//
//
// class CountryList extends ConsumerWidget {
//   const CountryList({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(countriesProvider);
//     final filteredCountries = ref.watch(filteredCountriesProvider);
//
//     if (state.isLoading) {
//       return const CircularProgressIndicator();
//     }
//
//     if (state.error != null) {
//       return Text(state.error!);
//     }
//
//     return ListView.builder(
//       itemCount: filteredCountries.length,
//       itemBuilder: (context, index) {
//         final country = filteredCountries[index];
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
//
// //
// // class CountryListScreen1 extends StatefulWidget {
// //   const CountryListScreen1({super.key});
// //
// //   @override
// //   _CountryListScreenState createState() => _CountryListScreenState();
// // }
// //
// // class _CountryListScreenState extends State<CountryListScreen1> {
// //   String _searchQuery = '';
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Color(0xFFf5f5f5),
// //       appBar: AppBar(
// //          backgroundColor: Color(0xFFf5f5f5),
// //         title: const Text('Explore Countries'),
// //         // Add this in the AppBar actions list
// //         actions: [
// //           IconButton(
// //             icon: const Icon(Icons.favorite),
// //             onPressed: () {
// //               Navigator.push(
// //                 context,
// //
// //                 MaterialPageRoute(
// //                   builder:(c)=>  const FavoritesScreen(),
// //                 ),
// //               );
// //             },
// //           ),
// //         ],
// //         bottom: PreferredSize(
// //           preferredSize: const Size.fromHeight(60),
// //           child: Padding(
// //             padding: const EdgeInsets.all(10.0),
// //             child: TextField(
// //               onChanged: (value) {
// //                 setState(() => _searchQuery = value.toLowerCase());
// //               },
// //               decoration: InputDecoration(
// //                 hintText: 'Search by name or capital...',
// //                 prefixIcon:  const Icon(Iconsax.search_normal_1),
// //                 filled: true,
// //                 fillColor: Colors.white,
// //                 border: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(12),
// //                   borderSide: BorderSide.none,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //       body: BlocBuilder<CountryCubit, CountryState>(
// //         builder: (context, state) {
// //           if (state is CountryLoading) {
// //             return const Center(child: CircularProgressIndicator());
// //           } else if (state is CountryLoaded) {
// //             final filteredCountries = state.countries
// //                 .where((country) =>
// //             "${country.name?.common!.toLowerCase()}${country.name?.official?.toLowerCase()}".toString().contains(_searchQuery) ??
// //                 false)
// //                 .toList();
// //
// //             if (filteredCountries.isEmpty) {
// //               return const Center(
// //                 child: Text(
// //                   'No countries found.',
// //                   style: TextStyle(fontSize: 18),
// //                 ),
// //               );
// //             }
// //
// //             return ListView.separated(
// //               padding: const EdgeInsets.all(12),
// //               itemCount: filteredCountries.length,
// //               separatorBuilder: (_, __) => const SizedBox(height: 8),
// //               itemBuilder: (context, index) {
// //                 final country = filteredCountries[index];
// //                 return FadeInRight(
// //
// //                   duration: Duration(milliseconds: 150*index),
// //                   child: Container(
// //                     decoration: BoxDecoration(
// //                       color: Colors.white,
// //                       borderRadius: BorderRadius.circular(12),
// //                       // boxShadow: [
// //                       //   BoxShadow(
// //                       //     color: Colors.grey.shade200,
// //                       //     blurRadius: 6,
// //                       //     offset: const Offset(0, 2),
// //                       //   ),
// //                       // ],
// //                     ),
// //                     child: ListTile(
// //                       leading: ClipRRect(
// //                         borderRadius: BorderRadius.circular(8),
// //                         child: Image.network(
// //                           country.flags?.png ?? '',
// //                           width: 80,
// //                           height: 50,
// //                           fit: BoxFit.cover,
// //                         ),
// //                       ),
// //                       title: Text(
// //                         country.name?.common ?? 'Unknown Country',
// //                         style: const TextStyle(
// //                           fontSize: 16,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                       subtitle: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           if (country.capital != null)
// //                             Text('Capital: ${country.capital?.join(', ')}'),
// //                           Row(
// //                             children: [
// //                               const Icon(Icons.group, size: 16),
// //                               const SizedBox(width: 4),
// //                               Text('${country.population}'),
// //                             ],
// //                           ),
// //                         ],
// //                       ),
// //                       trailing: IconButton(
// //                         icon: Icon(
// //                           country.isFavorite
// //                               ? Iconsax.heart5
// //                               : Iconsax.heart ,
// //                           color: country.isFavorite ? Colors.red : Colors.grey,
// //                         ),
// //                         onPressed: () => context
// //                             .read<CountryCubit>()
// //                             .toggleFavorite(country),
// //                       ),
// //                     ),
// //                   ),
// //                 );
// //               },
// //             );
// //           } else if (state is CountryError) {
// //             return Center(
// //               child: Text(
// //                 'Error: ${state.message}',
// //                 style: const TextStyle(fontSize: 16),
// //               ),
// //             );
// //           }
// //           return const SizedBox.shrink();
// //         },
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () => context.read<CountryCubit>().fetchCountries(),
// //         child: const Icon(Icons.refresh),
// //       ),
// //     );
// //   }
// // }
