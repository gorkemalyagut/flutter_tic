import 'package:flutter_tic/models/request.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class RequestHelper{
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path,'requests.db'),
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE requestTable(fullname TEXT, description TEXT,type TEXT,level INTEGER PRIMARY KEY AUTOINCREMENT ,phone TEXT)',
        );
      },
      version: 1,
    );
  }
  Future<int> insertRequest(List<RequestsDB> requests) async {
    int result = 0;
    final Database db = await initializeDB();
    for(var request in requests){
      result = await db.insert('requestTable', request.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    return result;
  }
  Future<List<RequestsDB>> retrieveRequest() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('requestTable');
    return queryResult.map((e) => RequestsDB.fromMap(e)).toList();
  }
  Future<void> deleteRequest(int level) async {
    final db = await initializeDB();
    await db.delete(
      'requestTable',
      where: "level = ?",
      whereArgs: [level],
    );
  }
}