import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minimal_country_explorer/core/const/app_color.dart';
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
    final isFavorite = ref.watch(favoritesNotifierProvider)
        .any((c) => c.name?.official == country.name?.official);

    return Scaffold(
      appBar: AppBar(
        title: Text(country.name!.common!),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Iconsax.heart5 : Iconsax.heart,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: () async {
              if (isFavorite) {
                await favoritesNotifier.removeFavorite(country);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Removed from favorites')),
                  );
                }
              } else {
                await favoritesNotifier.addFavorite(country);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to favorites')),
                  );
                }
              }
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: country.flags!.png.toString(),
            child: Image.network(
              country.flags?.png ?? '',
              width: double.infinity,
              fit: BoxFit.contain,
              height: 300,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Official',
                  style: AppStyle.textBlack16,
                ),
                Text(
                  '${country.name?.official ?? 'Unknown Country'} ',
                  style: AppStyle.textBlack18Bold,
                ),
                const SizedBox(height: 8),
                if (country.capital != null) ...[
                  Text(
                    'Capital',
                    style: AppStyle.textBlack16,
                  ),
                  Hero(
                      tag: '${country.capital?.join(', ')}',
                      child: Text('${country.capital?.join(', ')}')),
                ],
                const SizedBox(height: 8),
                ...[
                  Text(
                    'Population',
                    style: AppStyle.textBlack16,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.group, size: 16),
                      const SizedBox(width: 4),
                      Text(AppFunction.formatNumber(country.population)),
                    ],
                  ),
                ],
                const SizedBox(height: 8),

                Text(
                  'Currencies',
                  style: AppStyle.textBlack16,
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
                      style: AppStyle.textGray10,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Languages',
                  style: AppStyle.textBlack16,
                ),
                Wrap(
                  children: country.languages!.lang!.values
                      .map((e) => _langWidget(e))
                      .toList(),
                )
                // Row(
                //   children: [
                //     Text(
                //       '(${country.languages?.lang.toString()})',
                //       // style: AppStyle.textOrange20,
                //     ),
                //     const SizedBox(width: 4),
                //     // Text('${country.languages?.lang?.keys.first.toString()}'),
                //     const Spacer(),
                //
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _langWidget(text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      margin: EdgeInsets.only(right: 4, top: 8),
      decoration: BoxDecoration(
          color: AppColor.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: AppColor.blue.withOpacity(.2))),
      child: Text(
        text,
        style: AppStyle.textWhite12,
      ),
    );
  }
}
