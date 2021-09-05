import 'dart:io';
import 'package:flutter_tic/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class UserHelper{ 

  static final UserHelper instance = UserHelper._instance();
  static Database? _db ;

  UserHelper._instance();

  String userTable = 'user_table';
  String colId = 'id';
  String colMail = 'mail';
  String colName= 'name';
  String colUsername = 'username';
  String colPassword = 'password';


  Future<Database?> get database async {
    if(_db == null) {
    _db = await initializeDatabase();
    }
    return _db;
  }
  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'userDB.db';
    final userDatabase = await openDatabase(path, version: 1, onCreate: _createDB);
    return userDatabase;
  }
  void _createDB(Database db, int version) async {
    await db.execute(
          'CREATE TABLE $userTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colMail TEXT, $colName TEXT, $colUsername TEXT, $colPassword TEXT)'
    );
  }
  Future<List<Map<String, dynamic>>> getUserMapList() async {
		Database? db = await this.database;
    final List<Map<String,dynamic>> result = await db!.query(userTable);
    return result;
	}
  Future<List<User>> getUserList() async {
    final List<Map<String,dynamic>> userMapList = await getUserMapList();
    final List<User> userList = [];
    
    userMapList.forEach((userMap) { 
      userList.add(User.fromMap(userMap));
    });
    return userList;
  }
  Future<int> insertUser(User user) async{
    Database? db = await this.database;
   final int result = await db!.insert(
     userTable, 
     user.toMap(),);
    return result;
  }
  Future<int> updateUser(User user) async{
    Database? db = await this.database;
    final int result = await db!.update(userTable, user.toMap(),where: '$colId = ?',whereArgs: [user.id]);
    return result;
  }
  Future<int> deleteUser(int user) async{
    Database? db = await this.database;
    final int result = await db!.rawDelete('DELETE FROM $userTable WHERE $colId = $colId');
    return result;
  }
  Future<User?> checkLogin(String userName, String userPassword) async {
    Database? db = await this.database;
    final result = await db!.rawQuery("SELECT * FROM $userTable WHERE username = '$userName' and password = '$userPassword'");
    if(result.length > 0){
      return new User.fromMap(result.first);
    }
    return null;
    }
  
}

