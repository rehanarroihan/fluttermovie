import 'package:fluttermovie/app.dart';
import 'package:fluttermovie/base/entity_base.dart';
import 'package:sqflite/sqflite.dart';

abstract class Dao<T extends Entity> {

  String get tableName;

  T toEntity(Map<String, dynamic> map);

  T toListEntity(Map<String, dynamic> map);

  Future<List<T>> query({
    bool? distinct,
    List<String>? columns,
    String? where,
    List<dynamic>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final Database db = await App().dbConnection.database;

    List<Map<String, dynamic>> rawResults = await db.query(
      tableName,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );

    List<T> results = [];

    for (var res in rawResults) {
      results.add(toEntity(res));
    }

    return results;
  }

  Future<int> insert(Entity entity) async {
    final Database db = await App().dbConnection.database;

    return await db.insert(tableName, entity.toMap());
  }

  Future<int> delete(String where, List<String> whereArgs) async {
    final Database db = await App().dbConnection.database;

    return await db.delete(tableName, where: where, whereArgs: whereArgs);
  }

  Future<T?> findOne(String id, {String pkField = 'id'}) async {
    List<T> results = await query(where: '$pkField = ?', whereArgs: [id]);
    if (results.isNotEmpty) return results.first;

    return null;
  }

  Future<List<T>> rawQuery(String query) async {
    final Database db = await App().dbConnection.database;

    List<Map<String, dynamic>> rawResults = await db.rawQuery(query);

    List<T> results = [];
    for (var res in rawResults) {
      results.add(toEntity(res));
    }

    return results;
  }
}