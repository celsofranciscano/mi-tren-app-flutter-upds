import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crypto/crypto.dart'; // Para hashear las contraseñas
import 'dart:convert'; // Para convertir la contraseña en bytes

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('stations_new.db'); // Usa el mismo nombre de base de datos
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'stations_new.db'); // Ruta de la base de datos

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    try {
      // Tabla para estaciones favoritas
      await db.execute('''
        CREATE TABLE IF NOT EXISTS stations (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL
        )
      ''');

      // Tabla para estaciones recientes
      await db.execute('''
        CREATE TABLE IF NOT EXISTS recent_stations (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      // Nueva tabla para usuarios
      await db.execute('''
        CREATE TABLE IF NOT EXISTS users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          first_name TEXT NOT NULL,
          last_name TEXT NOT NULL,
          profile_url TEXT,
          email TEXT NOT NULL UNIQUE,
          password TEXT NOT NULL
        )
      ''');

    } catch (e) {
      // Manejar error de creación de tablas si es necesario
    }
  }

  // Método para añadir una estación favorita
  Future<int> addFavoriteStation(String name) async {
    try {
      final db = await instance.database;
      final data = {'name': name};
      return await db.insert('stations', data);
    } catch (e) {
      return -1;
    }
  }

  // Método para obtener estaciones favoritas
  Future<List<Map<String, dynamic>>> getFavoriteStations() async {
    try {
      final db = await instance.database;
      return await db.query('stations');
    } catch (e) {
      return [];
    }
  }

  // Método para eliminar una estación favorita
  Future<int> deleteFavoriteStation(int id) async {
    try {
      final db = await instance.database;
      return await db.delete('stations', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      return -1;
    }
  }

  // Método para añadir una estación reciente
  Future<int> addRecentStation(String name) async {
    try {
      final db = await instance.database;
      final data = {'name': name};
      return await db.insert('recent_stations', data);
    } catch (e) {
      return -1;
    }
  }

  // Método para obtener estaciones recientes
  Future<List<Map<String, dynamic>>> getRecentStations() async {
    try {
      final db = await instance.database;
      return await db.query(
        'recent_stations',
        orderBy: 'timestamp DESC',
        limit: 5,
      );
    } catch (e) {
      return [];
    }
  }

  // Método para eliminar una estación reciente
  Future<int> deleteRecentStation(int id) async {
    try {
      final db = await instance.database;
      return await db.delete(
        'recent_stations',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      return -1;
    }
  }

  // Métodos relacionados con la tabla users:

  // Método para hashear contraseñas
  String hashPassword(String password) {
    var bytes = utf8.encode(password); // Convertir la contraseña en bytes
    var digest = sha256.convert(bytes); // Hashear con SHA256
    return digest.toString();
  }

  // Método para validar email
  bool isValidEmail(String email) {
    String pattern = r'^[^@]+@[^@]+\.[^@]+';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  // Método para añadir un usuario
  Future<int> addUser(String firstName, String lastName, String profileUrl, String email, String password) async {
    try {
      final db = await instance.database;

      // Validar email antes de insertar
      if (!isValidEmail(email)) {
        return -1;
      }

      final data = {
        'first_name': firstName,
        'last_name': lastName,
        'profile_url': profileUrl,
        'email': email,
        'password': hashPassword(password) // Hashear la contraseña antes de guardarla
      };

      return await db.insert('users', data);
    } catch (e) {
      if (e.toString().contains('UNIQUE constraint failed')) {
        return -1;
      } else {
        return -1;
      }
    }
  }

  // Método para obtener los usuarios
  Future<List<Map<String, dynamic>>> getUsers() async {
    try {
      final db = await instance.database;
      return await db.query('users');
    } catch (e) {
      return [];
    }
  }

  // Método para eliminar un usuario
  Future<int> deleteUser(int id) async {
    try {
      final db = await instance.database;
      return await db.delete('users', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      return -1;
    }
  }

  // Método para autenticar un usuario (login)
  Future<Map<String, dynamic>?> authenticateUser(String email, String password) async {
    try {
      final db = await instance.database;
      final result = await db.query(
        'users',
        where: 'email = ? AND password = ?',
        whereArgs: [email, hashPassword(password)], // Comparar email y contraseña hasheada
      );

      if (result.isNotEmpty) {
        return result.first;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Método para cerrar la base de datos
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
