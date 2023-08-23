import 'package:fluttermovie/app.dart';
import 'package:fluttermovie/data/local/db/entities/movie_entity.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteDao {
  final _tableName = 'favorite';

  Future<int> insert(MovieEntity entity) async {
    final Database db = await App().dbConnection.database;
    return await db.insert(_tableName, entity.toMap());
  }

  Future<List<MovieEntity>> getAll() async {
    final Database db = await App().dbConnection.database;
    List<Map<String, dynamic>> rawResults = await db.query(_tableName);

    List<MovieEntity> result = [];
    for (var element in rawResults) {
      result.add(MovieEntity.fromMap(element));
    }

    return result;
  }
}