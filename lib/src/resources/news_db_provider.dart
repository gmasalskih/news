import 'dart:io';
import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/repository.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class NewsDbProvider implements Source, Cache {
  Database db;

  NewsDbProvider(){
    init();
  }

  init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'items.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
        CREATE TABLE Items(
        id INTEGER PRIMARY KEY,
        deleted INTEGER,
        type TEXT,
        by TEXT,
        time INTEGER,
        text TEXT,
        dead INTEGER,
        parent INTEGER,
        kids BLOB,
        url TEXT,
        score INTEGER,
        title TEXT,
        descendants INTEGER)
        """);
      },
    );
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final maps = await db.query(
      'Items',
      columns: null,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }
    return null;
  }

  @override
  Future<int> addItem(ItemModel item) {
    return db.insert('Items', item.toMap());
  }

  @override
  Future<List<int>> fetchTopIds() => null;
}

final NewsDbProvider newsDbProvider = NewsDbProvider();