import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:product_explorer/data/models/product_model.dart';

class FavoritesRepository {
  Database? _database;

  Future<void> init() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'product_explorer.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorites (
            id INTEGER PRIMARY KEY,
            title TEXT NOT NULL,
            price REAL NOT NULL,
            thumbnail TEXT NOT NULL,
            category TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Database get database {
    if (_database == null) {
      throw Exception('Database has not been initialized');
    }

    return _database!;
  }

  Future<void> addFavorite(ProductModel product) async {
    await database.insert(
      'favorites',
      {
        'id': product.id,
        'title': product.title,
        'price': product.price,
        'thumbnail': product.thumbnail,
        'category': product.category,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeFavorite(int id) async {
    await database.delete(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> isFavorite(int id) async {
    final result = await database.query(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );

    return result.isNotEmpty;
  }

  Future<List<ProductModel>> getFavorites() async {
    final result = await database.query('favorites');

    return result.map((map) {
      return ProductModel.fromJson(map);
    }).toList();
  }

  Future<void> clearFavorites() async {
    await database.delete('favorites');
  }

  Future<void> close() async {
    await _database?.close();
    _database = null;
  }
}