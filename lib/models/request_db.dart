import 'dart:io';
import 'package:flutter_tic/models/request.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class RequestHelper{ 

  static final RequestHelper instance = RequestHelper._instance();
  static Database? _db;

  RequestHelper._instance();

  String requestTable = 'request_table';
  String colId = 'id';
  String colDate = 'date';
  String colPriority = 'priority';
  String colFullName = 'fullname';
  String colPhone = 'phone';
  String colType = 'type';
  String colDescription = 'description';
  String colStatus = 'status';


  Future<Database?> get database async {
    if(_db == null) {
    _db = await initializeDatabase();
    }
    return _db;
  }
  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'requestDB.db';
    final requestDatabase = await openDatabase(path, version: 1, onCreate: _createDB);
    return requestDatabase;
  }
  void _createDB(Database db, int version) async {
    await db.execute(
          'CREATE TABLE $requestTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colDate TEXT, $colPriority TEXT, $colFullName TEXT, $colPhone TEXT, $colType TEXT, $colDescription TEXT, $colStatus INTEGER)'
    );
  }
  Future<List<Map<String, dynamic>>> getRequestMapList() async {
		Database? db = await this.database;
    final List<Map<String,dynamic>> result = await db!.query(requestTable);
    return result;
	}
  Future<List<RequestsDB>> getRequestList() async {
    final List<Map<String,dynamic>> requestMapList = await getRequestMapList();
    final List<RequestsDB> requestList = [];
    
    requestMapList.forEach((requestMap) { 
      requestList.add(RequestsDB.fromMap(requestMap));
    });
    //requestList.sort((requestA, requestB) => requestA.date!.compareTo(requestB.date!));
    return requestList;
  }
  Future<int> insertRequest(RequestsDB request) async{
    Database? db = await this.database;
   final int result = await db!.insert(
     requestTable, 
     request.toMap(),);
    return result;
  }
  Future<int> updateRequest(RequestsDB request) async{
    Database? db = await this.database;
    final int result = await db!.update(requestTable, request.toMap(),where: '$colId = ?',whereArgs: [request.id]);
    return result;
  }
  Future<int> deleteRequest(int id) async{
    Database? db = await this.database;
    final int result = await db!.delete(
      requestTable,
      where: '$colId = ?',
      whereArgs: [id],
    );
    return result;
  }
}

