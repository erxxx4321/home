import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import './db_models/user.dart';

class DatabaseHelper {
  static final _databaseName = "home.db";
  static final _databaseVersion = 1;

  static final table = 'Product';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    // await db.execute('''
    //       CREATE TABLE User (
    //         $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
    //         $columnName TEXT NOT NULL,
    //         $columnMiles INTEGER NOT NULL
    //       )
    //       ''');
  }
}
