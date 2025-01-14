// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:minimal_country_explorer/project/country_list/domain/entities/country.dart';
//
// import '../pages/country_detail_screen.dart';
// import '../providers/country_provider.dart';
//
// class CountryListTile extends ConsumerWidget {
//   final Country country;
//
//   const CountryListTile({super.key, required this.country});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ListTile(
//       leading: Image.network(
//         country.flags?.png ?? '',
//         width: 50,
//         errorBuilder: (context, error, stackTrace) =>
//             const Icon(Icons.flag, size: 50),
//       ),
//       title: Text(country.name!.official!),
//       subtitle: Text(country.capital.toString()),
//       trailing: IconButton(
//         icon: Icon(
//           country.isFavorite ? Icons.favorite : Icons.favorite_border,
//           color: country.isFavorite ? Colors.red : null,
//         ),
//         onPressed: () {
//           ref.read(countriesProvider.notifier).toggleFavorite(country);
//         },
//       ),
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => CountryDetailScreen(country: country),
//           ),
//         );
//       },
//     );
//   }
// }
