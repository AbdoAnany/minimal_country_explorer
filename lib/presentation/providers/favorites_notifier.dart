import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_country_explorer/data/datasources/database_helper.dart';
import 'package:minimal_country_explorer/data/models/country_model.dart';

class CheckFavoritesNotifier extends StateNotifier<bool> {
  final DatabaseHelper _dbHelper;
  final CountryModel country;
  CheckFavoritesNotifier(this._dbHelper, this.country) : super(false) {
    _checkIsFavorites(country);
  }

  Future<void> _checkIsFavorites(CountryModel country) async {
    final favorites = await _dbHelper.isFavorite(country);
    state = favorites;
  }
}

class FavoritesNotifier extends StateNotifier<List<CountryModel>> {
  final DatabaseHelper _dbHelper;

  FavoritesNotifier(this._dbHelper) : super([]) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final favorites = await _dbHelper.getFavorites();
    state = favorites;
  }

  Future<void> addFavorite(CountryModel country) async {
    await _dbHelper.insertFavorite(country);
    await _loadFavorites();
  }

  Future<void> removeFavorite(CountryModel country) async {
    await _dbHelper.deleteFavorite(country);
    await _loadFavorites();
  }

  void toggleFavorite(CountryModel country) {
    final isFavorite =
        state.any((element) => element.name!.common == country.name!.common);

    if (isFavorite) {
      state = state
          .where((element) => element.name!.common != country.name!.common)
          .toList();
    } else {
      state = [...state, country.copyWith(isFavorite: true)];
    }
  }
}
