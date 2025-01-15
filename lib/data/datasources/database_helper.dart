import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/country_model.dart';




class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('favorites.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);
 // await   clearFavorites();
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorites (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            capital TEXT,
            population INTEGER,
            flag TEXT,
            languages TEXT,
            currencies TEXT,
            is_favorite INTEGER DEFAULT 1
          )
        ''');
      },
    );
  }

  Future<int> insertFavorite(CountryModel country) async {
    final db = await instance.database;

    final row = {
      'name': country.name?.official ?? '',
      'capital': country.capital?.join(', ') ?? '',
      'population': country.population ?? 0,
      'flag': country.flags?.png ?? '',
      'languages': json.encode(country.languages?.toJson() ?? {}),
      'currencies': json.encode(country.currencies?.toJson() ?? {}),
      'is_favorite': 1
    };

    try {
      await db.delete(
        'favorites',
        where: 'name = ?',
        whereArgs: [country.name?.official ?? ''],
      );

      return await db.insert('favorites', row);
    } catch (e) {
      print('Error inserting favorite: $e');
      return -1;
    }
  }

  Future<List<CountryModel>> getFavorites() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');

    return maps.map((map) {
      Map<String, dynamic> languagesMap = {};
      Map<String, dynamic> currenciesMap = {};

      try {
        if (map['languages'] != null && map['languages'].toString().isNotEmpty) {
          languagesMap = json.decode(map['languages']);
        }
      } catch (e) {
        print('Error decoding languages: $e');
        languagesMap = {};
      }

      try {
        if (map['currencies'] != null && map['currencies'].toString().isNotEmpty) {
          currenciesMap = json.decode(map['currencies']);
        }
      } catch (e) {
        print('Error decoding currencies: $e');
        // If decoding fails, use empty map
        currenciesMap = {};
      }


      return CountryModel(
        name: Name(
          common: map['name'],
          official: map['name'],
        ),
        flags: Flags(
          png: map['flag'],
          svg: map['flag']
              ?.replaceAll('w320', '')
              ?.replaceAll('png', 'svg'),
        ),
        capital: map['capital']?.toString().split(', '),
        population: map['population'] as int?,
        currencies:Currencies.fromJson(currenciesMap),
        languages: Languages.fromJson(languagesMap),
        isFavorite: map['is_favorite'] == 1,
      );
    }).toList();
  }

  // Delete a single favorite by name
  Future<int> deleteFavorite(String name) async {
    try {
      final db = await instance.database;
      return await db.delete(
        'favorites',
        where: 'name = ?',
        whereArgs: [name],
      );
    } catch (e) {
      print('Error deleting favorite: $e');
      return -1;
    }
  }

  // Delete a favorite using CountryModel
  Future<int> deleteFavoriteCountry(CountryModel country) async {
    try {
      return await deleteFavorite(country.name?.official ?? '');
    } catch (e) {
      print('Error deleting favorite country: $e');
      return -1;
    }
  }

  // Check if a country is favorite
  Future<bool> isFavorite(String name) async {
    try {
      final db = await instance.database;
      final List<Map<String, dynamic>> result = await db.query(
        'favorites',
        where: 'name = ?',
        whereArgs: [name],
      );
      return result.isNotEmpty;
    } catch (e) {
      print('Error checking favorite status: $e');
      return false;
    }
  }

  // Clear all favorites
  Future<int> clearFavorites() async {
    try {
      final db = await instance.database;
      return await db.delete('favorites');
    } catch (e) {
      print('Error clearing favorites: $e');
      return -1;
    }
  }

  // Toggle favorite status
  Future<bool> toggleFavorite(CountryModel country) async {
    try {
      final name = country.name?.official ?? '';
      final isFav = await isFavorite(name);

      if (isFav) {
        await deleteFavorite(name);
        return false;
      } else {
        await insertFavorite(country);
        return true;
      }
    } catch (e) {
      print('Error toggling favorite: $e');
      return false;
    }
  }
}