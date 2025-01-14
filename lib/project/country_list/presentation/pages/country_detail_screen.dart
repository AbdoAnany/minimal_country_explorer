// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:minimal_country_explorer/project/country_list/domain/entities/country.dart';
//
// import '../providers/country_provider.dart';
//
// class CountryDetailScreen extends ConsumerWidget {
//   final Country country;
//
//   const CountryDetailScreen({super.key, required this.country});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(country.name?.common ?? ''),
//         actions: [
//           IconButton(
//             icon: Icon(
//               country.isFavorite ? Icons.favorite : Icons.favorite_border,
//               color: country.isFavorite ? Colors.red : null,
//             ),
//             onPressed: () {
//               ref.read(countriesProvider.notifier).toggleFavorite(country);
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Image.network(
//                 country.flags?.png ?? '',
//                 height: 200,
//                 errorBuilder: (context, error, stackTrace) =>
//                     const Icon(Icons.flag, size: 200),
//               ),
//             ),
//             const SizedBox(height: 20),
//             _buildInfoSection('Capital', country.capital.toString()),
//             _buildInfoSection(
//                 'Population', country.population.toString()),
//             _buildInfoSection('Currencies',
//                 country.currencies.toString()),
//             _buildInfoSection('Languages',
//                 country.languages.toString()),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoSection(String title, String content) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             content,
//             style: const TextStyle(fontSize: 16),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
