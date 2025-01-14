// lib/data/datasources/database_helper.dart
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

    // Delete existing database to ensure clean slate
    // await deleteDatabase(path);

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
            is_favorite INTEGER DEFAULT 1
          )
        ''');
      },
    );
  }

  Future<int> insertFavorite(CountryModel country) async {
    final db = await instance.database;

    final Map<String, dynamic> row = {
      'name': country.name?.official ?? '',
      'capital': country.capital?.join(', ') ?? '',
      'population': country.population ?? 0,
      'flag': country.flags?.png ?? '',
      'languages': country.languages?.eng ?? '',
      'is_favorite': 1
    };

    try {
      // First try to delete any existing entry to avoid conflicts
      await db.delete(
        'favorites',
        where: 'name = ?',
        whereArgs: [country.name?.official ?? ''],
      );

      // Then insert the new entry
      return await db.insert('favorites', row);
    } catch (e) {
      print('Error inserting favorite: $e');
      return -1;
    }
  }

  Future<List<CountryModel>> getFavorites() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');


    print('getFavorites maps  ${maps.length}');

    return maps.map((map) {
      return CountryModel(
        name: Name(
          common: map['name'],
          official: map['name'],
        ),
        flags: Flags(
          png: map['flag'],
          svg: map['flag']?.toString().replaceAll('w320', '').replaceAll('png', 'svg'),
          alt: null,
        ),
        capital: map['capital']?.toString().split(', '),
        population: map['population'],
        languages: Languages(eng: map['languages']),
        isFavorite: true,
      );
    }).toList();
  }

  Future<int> deleteFavorite(String name) async {
    final db = await instance.database;
    return await db.delete(
      'favorites',
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  Future<bool> isFavorite(String name) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> result = await db.query(
      'favorites',
      where: 'name = ?',
      whereArgs: [name],
      limit: 1,
    );
    return result.isNotEmpty;
  }

  // Helper method to clear all favorites
  Future<void> clearFavorites() async {
    final db = await instance.database;
    await db.delete('favorites');
  }
}
// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper._internal();
//   static Database? _database;
//
//   factory DatabaseHelper() => _instance;
//
//   DatabaseHelper._internal();
//
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }
//
//   Future<Database> _initDatabase() async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, 'favorites.db');
//
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _onCreate,
//     );
//   }
//
//   Future<void> _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE favorites(
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         name TEXT,
//         capital TEXT,
//         flag TEXT,
//         population INTEGER,
//         currencies TEXT,
//         languages TEXT
//       )
//     ''');
//   }
//
//   Future<void> insertFavorite(CountryModel country) async {
//     final db = await database;
//     await db.insert('favorites', country.toJson());
//   }
//
//   Future<void> deleteFavorite(String name) async {
//     final db = await database;
//     await db.delete('favorites', where: 'name = ?', whereArgs: [name]);
//   }
//
//   Future<List<CountryModel>> getFavorites() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('favorites');
//     return maps.map((json) => CountryModel.fromJson(json)).toList();
//   }
// }