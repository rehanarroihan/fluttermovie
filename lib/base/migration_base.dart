import 'package:sqflite/sqflite.dart';

abstract class MigrationBase {
  Future<void> up(Database db);
}