import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/const/app_style.dart';
import '../../core/helper/app_helper_function.dart';
import '../providers/country_provider.dart';
import '../../data/models/country_model.dart';

class CountryDetailScreen extends ConsumerWidget {
  final CountryModel country;

  const CountryDetailScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesNotifier = ref.read(favoritesNotifierProvider.notifier);
    final isFavorite = ref.watch(favoritesNotifierProvider).contains(country);

    return Scaffold(
      appBar: AppBar(
        title: Text(country.name!.common!),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Iconsax.heart5 : Iconsax.heart,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              if (isFavorite) {
                favoritesNotifier.removeFavorite(country);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Removed from favorites')),
                );
              } else {
                favoritesNotifier.addFavorite(country);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Added to favorites')),
                );
              }
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(

            country.flags?.png ?? '',
            width: double.infinity,
            fit: BoxFit.contain,
          ),


          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Official ${ country.name?.official ?? 'Unknown Country'} '
                 ,
                  style: AppStyle.textBlack18Bold,
                ), Text('Official ${ country.name?.official ?? 'Unknown Country'} '
                 ,
                  style: AppStyle.textBlack18Bold,
                ),
                if (country.capital != null)
                  Text('Capital: ${country.capital?.join(', ')}'),
                Row(
                  children: [
                    const Icon(Icons.group, size: 16),
                    const SizedBox(width: 4),
                    Text(AppFunction.formatNumber(country.population)),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${country.currencies?.date?.values.first['symbol'].toString()}',
                      style: AppStyle.textOrange20,
                    ),
                    const SizedBox(width: 4),
                    Text('${country.currencies?.date?.keys.first.toString()}'),
                    const Spacer(),
                    Text(
                      '(${country.currencies?.date?.values.first['name'].toString()})',
                      style: AppStyle.textGray8,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
