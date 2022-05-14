import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class DBH {
  DBH._();
  static final DBH dH = DBH._();
  static Database? _db;
  Database get get_db => _db!;
  void initDB() async {
    _db ??= await open_DB();
  }
  DBH._createInstance();
  Future<Database> open_DB() async {
    String path = join(await getDatabasesPath(), "DB1.db");
    var exists = await databaseExists(path);
    if (!exists) {
      print("Creating new copy from asset");
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      ByteData data = await rootBundle.load(join("assets", "DB1.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
    return await openDatabase(
        path, readOnly: false,

    );
  }
  Future<void> close_DB() async {
    _db?.close();
  }
}
