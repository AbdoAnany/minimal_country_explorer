// lib/presentation/widgets/shimmer_loading.dart
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../data/models/country_model.dart';
import 'country_card.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemBuilder: (context, index) => CountryCard(
          country: CountryModel(
            // id: 0,
              name: Name(
                common: 'Egypt',
                official: 'Egypt Egypt',
                nativeName: NativeName(
                  date: {"common": 'EgyptEgypt', "official": 'EgyptEgypt'},
                ),
              ),
              capital: ['Egypt'],
              flags: Flags(png: 'https://flagcdn.com/w320/gs.png')),
        ),
      ),
    );
  }
}
