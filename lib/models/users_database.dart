import 'package:flutter_tic/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserHelper{

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path,'user.db'),
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE usersTable(mail TEXT PRIMARY KEY, password TEXT, name TEXT)',
        );
      },
      version: 1,
    );
  }
  Future<void> insertUser(User user) async {
    final db = await initializeDB();
    await db.insert(
      'usersTable',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteUser(String mail) async {
    final db = await initializeDB();
    await db.delete(
      'usersTable',
      where: "mail = ?",
      whereArgs: [mail],
    );
  }
  Future<User?> getLogin(String mail, String password) async {  
    final Database db = await initializeDB();  
    var result = await db.rawQuery("SELECT * FROM usersTable WHERE mail = '$mail' and password = '$password'"); 
    if (result.length > 0) {  
        return new User.fromMap(result.first);
    }
    return null;  
  }
}