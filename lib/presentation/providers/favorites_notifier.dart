import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_country_explorer/data/datasources/database_helper.dart';
import 'package:minimal_country_explorer/data/models/country_model.dart';

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
  final c=  await _dbHelper.deleteFavorite(country);
  print('cccc ${c}');
    await _loadFavorites();
  }
}
