import 'package:event_tracker_pm26s/models/event.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const _dbName = 'event_tracker.db';
  static const _dbVersion = 1;

  DatabaseProvider._init();
  static final DatabaseProvider instance = DatabaseProvider._init();

  Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final dbPath = '$databasesPath/$_dbName';
    return await openDatabase(
      dbPath,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(''' 
      CREATE TABLE ${Event.tableName} (
        ${Event.fieldId} TEXT PRIMARY KEY,
        ${Event.fieldName} TEXT,
        ${Event.fieldDescription} TEXT,
        ${Event.fieldType} TEXT,
        ${Event.fieldTicketPrice} NUMERIC,
        ${Event.fieldLongitude} NUMERIC,
        ${Event.fieldLatitude} NUMERIC,
        ${Event.fieldUrl} TEXT,
        ${Event.fieldStartDate} TEXT,
        ${Event.fieldImageURL} TEXT
      );
    ''');
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
    }
  }
}
