import 'package:flutter/material.dart';
import 'package:minimal_country_explorer/core/const/app_style.dart';
import 'package:minimal_country_explorer/core/helper/app_helper_function.dart';

import '../../data/models/country_model.dart';
import '../screens/country_detail_screen.dart';

class CountryCard extends StatelessWidget {
  final CountryModel country;

  const CountryCard({
    super.key,
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
            child: Hero(
              tag: country.flags!.png.toString(),
              child: Image.network(
                country.flags?.png ?? '',
                width: 100,
                height: 75,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Hero(
            tag: "${country.name?.common?.toString()}",
            child: Text(
              country.name?.common ?? 'Unknown Country',
              style: AppStyle.textBlack18Bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (country.capital != null)
                Hero(
                    tag: '${country.capital?.join(', ')}',
                    child: Material(
                        child:
                            Text('Capital: ${country.capital?.join(', ')}'))),
              Row(
                children: [
                  const Icon(Icons.group, size: 16),
                  const SizedBox(width: 4),
                  Text(AppFunction.formatNumber(country.population)),
                ],
              ),
              if (country.currencies != null &&
                  country.currencies!.date!.isNotEmpty)
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
            ],
          ),
        ),
      ),
    );
  }
}
