import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

String tableName = 'store_data';

class AppBd {
  int id = 0;
  String name = '';
  String userName = '';

  Map<String, dynamic> toMap() {
    Map<String, dynamic> newMap = Map();
    if (id > 0) {
      newMap['id'] = id.toString();
    }
    newMap['name'] = name;
    newMap['userName'] = userName;
    return newMap;
  }

  /*  конвертирование в мап из базы */
  Map<String, dynamic> fromMap(map) {
    return {
      'id': map['id'],
      'name': map['name'],
      'userName': map['userName']
    };
  }

  /* ассинхроноо получает,создает и открывает таблицу баз данных  */
  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), '$tableName.db'),
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute("""
         CREATE TABLE $tableName
               ( 
                id INTEGER PRIMARY KEY AUTOINCREMENT , 
                name VARCHAR(300), 
                userName  VARCHAR(300)
               )
                """);
      },
      version: 1,
    );
  }

  /* асинхроно записывает в базу данных  */
  Future<dynamic> insertSettings({name, userName}) async {
    this.name = name;
    this.userName = userName;

    final db = await _getDatabase();
    dynamic insertData = await db.insert(
      tableName,
      toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return insertData;
  }

/*   асинхроно  получает массив всех записей    */
  Future<List> getSettingsList() async {
    // Get a reference to the database.
    final db = await _getDatabase();

    final List<Map<String, dynamic>> maps =
        await db.query(tableName, orderBy: "id DESC", limit: 1);

    return List.generate(maps.length, (i) {
      return fromMap(maps[i]);
    });
  }

  /*   асинхроно  получает один запись    */
  Future<List> getOneSetting(id) async {
    // Get a reference to the database.
    final db = await _getDatabase();

    final maps = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return List.generate(maps.length, (i) {
      return fromMap(maps[i]);
    });
  }

  Future<dynamic> updateSetting({id,name, userName}) async {
    // Get a reference to the database.
    final db = await _getDatabase();
    this.id = id;
    this.name = name;
    this.userName = userName;

    dynamic updateData = await db.update(
      tableName,
      toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );

    return updateData;
  }

  /* удаление по условию */
  Future<void> deleteSetting(int id) async {
    final db = await _getDatabase();

    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /* удаление всех записей */
  Future<void> clearSettings() async {
    final db = await _getDatabase();

    await db.delete(
      tableName,
      where: 'id > ?',
      whereArgs: [0],
    );
  }
}
