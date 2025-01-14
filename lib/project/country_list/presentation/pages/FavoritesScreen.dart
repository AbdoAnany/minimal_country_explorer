// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
//
// class FavoritesScreen extends StatelessWidget {
//   const FavoritesScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Favorite Countries'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () => context.read<CountryCubit>().fetchCountries(),
//           ),
//         ],
//       ),
//       body: BlocBuilder<CountryCubit, CountryState>(
//         builder: (context, state) {
//           if (state is CountryLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is CountryLoaded) {
//             final favoriteCountries = state.countries
//                 .where((country) => country.isFavorite)
//                 .toList();
//
//             if (favoriteCountries.isEmpty) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(
//                       Icons.favorite_border,
//                       size: 64,
//                       color: Colors.grey,
//                     ),
//                     const SizedBox(height: 16),
//                     const Text(
//                       'No favorite countries yet',
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     ElevatedButton(
//                       onPressed: () => Navigator.pop(context),
//                       child: const Text('Add Some Favorites'),
//                     ),
//                   ],
//                 ),
//               );
//             }
//
//             return ListView.separated(
//               padding: const EdgeInsets.all(16),
//               itemCount: favoriteCountries.length,
//               separatorBuilder: (_, __) => const SizedBox(height: 12),
//               itemBuilder: (context, index) {
//                 final country = favoriteCountries[index];
//                 return Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     children: [
//                       // Flag Image
//                       ClipRRect(
//                         borderRadius: const BorderRadius.vertical(
//                           top: Radius.circular(12),
//                         ),
//                         child: AspectRatio(
//                           aspectRatio: 16 / 9,
//                           child: Image.network(
//                             country.flags?.png ?? '',
//                             fit: BoxFit.cover,
//                             errorBuilder: (context, error, stackTrace) {
//                               return Container(
//                                 color: Colors.grey[300],
//                                 child: const Icon(Icons.image_not_supported),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//
//                       // Country Details
//                       Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     country.name?.common ?? 'Unknown Country',
//                                     style: const TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                                 IconButton(
//                                   icon: const Icon(
//                                     Icons.favorite,
//                                     color: Colors.red,
//                                   ),
//                                   onPressed: () => context
//                                       .read<CountryCubit>()
//                                       .toggleFavorite(country),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 8),
//                             if (country.capital != null && country.capital!.isNotEmpty)
//                               Row(
//                                 children: [
//                                   const Icon(Icons.location_city, size: 20),
//                                   const SizedBox(width: 8),
//                                   Text(
//                                     'Capital: ${country.capital!.join(", ")}',
//                                     style: const TextStyle(fontSize: 16),
//                                   ),
//                                 ],
//                               ),
//                             const SizedBox(height: 4),
//                             Row(
//                               children: [
//                                 const Icon(Icons.people, size: 20),
//                                 const SizedBox(width: 8),
//                                 Text(
//                                   'Population: ${country.population?.toString().replaceAllMapped(
//                                     RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
//                                     (Match m) => '${m[1]},'
//                                   )}',
//                                   style: const TextStyle(fontSize: 16),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           } else if (state is CountryError) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(
//                     Icons.error_outline,
//                     size: 48,
//                     color: Colors.red,
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     'Error: ${state.message}',
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () => context.read<CountryCubit>().fetchCountries(),
//                     child: const Text('Try Again'),
//                   ),
//                 ],
//               ),
//             );
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
// }