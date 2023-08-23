import 'package:fluttermovie/data/local/db/migrations/migration_01_create_db.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FlutterMovieDatabase {
  static final FlutterMovieDatabase instance = FlutterMovieDatabase._init();

  static Database? _database;

  FlutterMovieDatabase._init();

  final migrations = [
    Migration01CreateDb()
  ];

  Future<Database> get database async {
    if (_database != null) return _database!;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'movie.db');

    _database = await openDatabase(
      path,
      version: migrations.length,
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        for (int i = oldVersion; i < newVersion; i++) {
          await migrations[i].up(db);
        }
      },
    );

    return _database!;
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}