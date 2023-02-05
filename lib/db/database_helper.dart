import 'dart:io';
import 'package:isaac_flutter/models/items.dart';
import 'package:isaac_flutter/models/characters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/isaac.db';

    var isaacDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );

    return isaacDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''Create TABLE items (
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  name TEXT,
                  description TEXT,
                  image TEXT);
                  Create TABLE characters (
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  name TEXT,
                  object TEXT,
                  image TEXT);
    
    ''');
  }

  Future<int> insertItem(Items item) async {
    Database db = await instance.database;
    int result = await db.insert('items', item.toMap());
    return result;
  }

  Future<List<Items>> getAllItems() async {
    List<Items> items = [];

    Database db = await instance.database;

    List<Map<String, dynamic>> listMap = await db.query('items');

    for (var itemMap in listMap) {
      Items item = Items.fromMap(itemMap);
      items.add(item);
    }

    return items;
  }

  Future<int> deleteItem(int id) async {
    Database db = await instance.database;
    int result = await db.delete('items', where: 'id=?', whereArgs: [id]);
    return result;
  }

  Future<int> updateItem(Items item) async {
    Database db = await instance.database;
    int result = await db.update('items', item.toMap(), where: 'id=?', whereArgs: [item.id]);
    return result;
  }

  Future<int> insertCharacter(Characters character) async {
    Database db = await instance.database;
    int result = await db.insert('characters', character.toMap());
    return result;
  }

  Future<List<Characters>> getAllCharacters() async {
    List<Characters> characters = [];

    Database db = await instance.database;

    List<Map<String, dynamic>> listMap = await db.query('characters');

    for (var characterMap in listMap) {
      Characters character = Characters.fromMap(characterMap);
      characters.add(character);
    }

    return characters;
  }

  Future<int> deleteCharacter(int id) async {
    Database db = await instance.database;
    int result = await db.delete('characters', where: 'id=?', whereArgs: [id]);
    return result;
  }

  Future<int> updateCharacter(Characters character) async {
    Database db = await instance.database;
    int result = await db.update('characters', character.toMap(), where: 'id=?', whereArgs: [character.id]);
    return result;
  }

}