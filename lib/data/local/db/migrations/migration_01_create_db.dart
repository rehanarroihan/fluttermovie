import 'package:fluttermovie/base/migration_base.dart';
import 'package:sqflite/sqflite.dart';

class Migration01CreateDb extends MigrationBase {
  @override
  Future<void> up(Database db) async {
    await db.execute("CREATE TABLE favorite("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "movie_id INTEGER,"
        "image_url TEXT,"
        "title TEXT,"
        "genres TEXT,"
        "year TEXT"
      ")"
    );
  }
}