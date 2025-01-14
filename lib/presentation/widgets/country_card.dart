// lib/presentation/widgets/country_card.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../data/models/country_model.dart';
import '../screens/country_detail_screen.dart';

class CountryCard extends StatelessWidget {
  final CountryModel country;

  const CountryCard({super.key,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CountryDetailScreen(country: country),
            )),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),

        ),
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              country.flags?.png ?? '',
              width: 80,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            country.name?.common ?? 'Unknown Country',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (country.capital != null)
                Text('Capital: ${country.capital?.join(', ')}'),
              Row(
                children: [
                  const Icon(Icons.group, size: 16),
                  const SizedBox(width: 4),
                  Text('${country.population}'),
                ],
              ),     Tooltip(
                message: '${country.currencies?.date?.values.first['name'].toString()}',
                child: Row(
                  children: [
                    Text('${country.currencies?.date?.values.first['symbol'].toString()}'),
                    const SizedBox(width: 4),
                    Text('${country.currencies?.date?.keys.first.toString()}'),
                  ],
                ),
              ),
            ],
          ),
          // trailing: IconButton(
          //   icon: Icon(
          //     country.isFavorite
          //         ? Iconsax.heart5
          //         : Iconsax.heart ,
          //     color: country.isFavorite ? Colors.red : Colors.grey,
          //   ),
          //   onPressed: () => context
          //       .read<CountryCubit>()
          //       .toggleFavorite(country),
          // ),
        ),
      ),
    );

    //   Card(
    //   child: ListTile(
    //     leading: Image.network(country.flags!.png!),
    //     title: Text(country.name!.common!),
    //     subtitle: Text(country.capital.toString()),
    //     onTap: () => Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => CountryDetailScreen(country: country),
    //       ),
    //     ),
    //   ),
    // );
  }
}
