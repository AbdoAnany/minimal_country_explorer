// lib/data/datasources/country_api_service.dart
import 'package:dio/dio.dart';
import 'package:minimal_country_explorer/data/models/country_model.dart';

class CountryApiService {
  final Dio _dio = Dio();

  Future<List<CountryModel>> fetchCountries() async {
    try {
      final response = await _dio.get(
        'https://restcountries.com/v3.1/all?fields=name,capital,flags,population,currencies,languages',
      );
      return (response.data as List)
          .map((json) => CountryModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to load countries: $e');
    }
  }
}
