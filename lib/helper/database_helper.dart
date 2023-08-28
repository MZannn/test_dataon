import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:test_dataon/data/models/register_model.dart';

class DatabaseHelper {
  static late Database _database;
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;

  static Future<void> initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE registrations(id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, password TEXT)',
        );
      },
      version: _databaseVersion,
    );
  }

  static Future<void> insertRegistration(
      Map<String, dynamic> registration) async {
    await _database.insert(
      'registrations',
      registration,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getTableData(String tableName) async {
    _database = await openDatabase(
      join(await getDatabasesPath(), _databaseName),
    );

    return _database.query(tableName);
  }

  Future<RegisterModel?> loginByEmail(String email) async {
    _database = await openDatabase(
      join(await getDatabasesPath(), _databaseName),
    );
    print(_database);
    final List<Map<String, dynamic>> maps = await _database.query(
      'registrations',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return RegisterModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<void> updatePasswordByEmail(String email, String newPassword) async {
    _database = await openDatabase(
      join(await getDatabasesPath(), _databaseName),
    );

    await _database.update(
      'registrations',
      {'password': newPassword},
      where: 'email = ?',
      whereArgs: [email],
    );
  }
}
