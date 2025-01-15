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
      'name': json.encode(country.name?.toJson() ?? {}) ,
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
  Map<String, dynamic> _handelMap(type){
    try {
      if (type != null &&type.toString().isNotEmpty) {
        return  json.decode(type);
      }
    } catch (e) {
      print('Error decoding $type: $e');
      return  {};
    }
    return  {};
  }
  Future<List<CountryModel>> getFavorites() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');

    return maps.map((map) {

      return CountryModel(
        name: Name.fromJson(_handelMap(map['name'])),
        flags: Flags(
          png: map['flag'],
          svg: map['flag']
              ?.replaceAll('w320', '')
              ?.replaceAll('png', 'svg'),
        ),
        capital: map['capital']?.toString().split(', '),
        population: map['population'] as int?,
        currencies:Currencies.fromJson(_handelMap(map['currencies'])),
        languages: Languages.fromJson(_handelMap(map['languages'])),
        isFavorite: map['is_favorite'] == 1,
      );
    }).toList();
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
  Future<int> deleteFavorite(String name) async {
    try {
      final db = await instance.database;

      // Create a Name object and encode it the same way as insert
      final nameObj = Name(official: name, common: name);
      final encodedName = json.encode({'official': name, 'common': name});

      return await db.delete(
        'favorites',
        where: 'name = ?',
        whereArgs: [encodedName],
      );
    } catch (e) {
      print('Error deleting favorite: $e');
      return -1;
    }
  }

  Future<bool> isFavorite(String name) async {
    try {
      final db = await instance.database;
      final encodedName = json.encode({'official': name, 'common': name});

      final List<Map<String, dynamic>> result = await db.query(
        'favorites',
        where: 'name = ?',
        whereArgs: [encodedName],
      );
      return result.isNotEmpty;
    } catch (e) {
      print('Error checking favorite status: $e');
      return false;
    }
  }

  Future<bool> toggleFavorite(CountryModel country) async {
    try {
      final name = country.name?.official ?? '';
      final isFav = await isFavorite(name);

      if (isFav) {
        final result = await deleteFavorite(name);
        return result > 0;
      } else {
        final result = await insertFavorite(country);
        return result > 0;
      }
    } catch (e) {
      print('Error toggling favorite: $e');
      return false;
    }
  }
}