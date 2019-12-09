import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// database table and column names
final String tableWords = 'words';
final String columnId = '_id';
final String columnProduct = 'product';
final String columnBarcode = 'barcode';

// data model class
class Word {
  int id;
  String product;
  String barcode;

  Word();

  // convenience constructor to create a Word object
  Word.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    product = map[columnProduct];
    barcode = map[columnBarcode];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{columnProduct: product, columnBarcode: barcode};
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}

// singleton class to manage the database
class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableWords (
                $columnId INTEGER PRIMARY KEY,
                $columnProduct TEXT NOT NULL,
                $columnBarcode TEXT NOT NULL
              )
              ''');
  }

  // Database helper methods:

  Future<void> insert(Word word) async {
    Database db = await database;
    await db.insert(tableWords, word.toMap());
  }

  Future<Word> queryWord(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableWords,
        columns: [columnId, columnProduct, columnBarcode],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Word.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Word>> queryAllWords() async {
    Database db = await database;
    List<Map> maps = await db.query(tableWords);
    if (maps.length > 0) {
      List<Word> words = [];
      maps.forEach((map) => words.add(Word.fromMap(map)));
      return words;
    }
    return null;
  }

  deleteAll() async {
    Database db = await database;
    return await db.rawDelete('DELETE FROM ' + tableWords);
  }

  Future<int> update(Word word) async {
    Database db = await database;
    return await db.update(tableWords, word.toMap(),
        where: '$columnId = ?', whereArgs: [word.id]);
  }
}
