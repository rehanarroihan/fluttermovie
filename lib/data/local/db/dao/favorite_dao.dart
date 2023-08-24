import 'package:fluttermovie/base/dao_base.dart';
import 'package:fluttermovie/base/entity_base.dart';

class FavoriteDao extends Dao {

  @override
  String get tableName => 'favorite';

  @override
  Entity toEntity(Map<String, dynamic> map) {
    throw UnimplementedError();
  }

  @override
  Entity toListEntity(Map<String, dynamic> map) {
    throw UnimplementedError();
  }

  /*Future<int> insert(MovieEntity entity) async {
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
  }*/
}