import 'package:minimal_country_explorer/project/country_list/data/local/data_sources/database_helper.dart';
import 'package:minimal_country_explorer/project/country_list/data/remote/data_sources/api_service.dart';

import '../../domain/entities/country.dart';



class CountryRepository {
  final CountryApiService apiService;
  final DatabaseHelper databaseHelper;

  CountryRepository(this.apiService, this.databaseHelper);

  Future<List<Country>> fetchCountries() async {
    try {
      final data = await apiService.fetchCountries();
      return data.map((e) => Country.fromJson(e)).toList();
    } catch (e) {
      print('Error fetching countries: $e');
      // Handle offline mode
      final localData = await databaseHelper.fetchFavorites();
      return localData;
    }
  }
  getFavorites() async {
    final localData = await databaseHelper.fetchFavorites();
    return localData;
  }

  Future<void> saveToFavorites(Country country) async {
    await databaseHelper.insertFavorite(country);
  }  Future<void> deleteFromFavorites(Country country) async {
    await databaseHelper.deleteFavorite(country.name!.official!);
  }
}


