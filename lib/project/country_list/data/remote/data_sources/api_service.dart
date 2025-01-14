import 'dart:convert';

import 'package:dio/dio.dart';

class CountryApiService {
  final Dio _dio = Dio();

  Future<List<Map<String, dynamic>>> fetchCountries() async {
    const url = 'https://restcountries.com/v3.1/all?fields=name,flags,capital,population,currencies,languages';
    try {
      final response = await _dio.get(url);
      return List<Map<String, dynamic>>.from(response.data);
    } catch (e) {
      throw Exception('Failed to fetch countries: $e');
    }
  }
}


// class CountryApiService {
//   final Dio _dio = Dio();
//
//   Future<List<CountryModel>> fetchCountries() async {
//     try {
//       final response = await _dio.get('https://restcountries.com/v3.1/all?fields=name,capital,flags,population,currencies,languages');
//       return (response.data as List).map((json) => CountryModel.fromJson(json)).toList();
//     } catch (e) {
//       throw Exception('Failed to load countries: $e');
//     }
//   }
// }